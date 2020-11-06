#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "pgmfiles.h"
#include "diff2d.h"
#include <time.h>        // tempo de execução (clock())
#include <x86intrin.h>   // tempo de execução por ciclos (rdtsc())
#include <stdint.h>      // tipos de variaveis para calculo de ciclos

// https://docs.microsoft.com/en-us/cpp/intrinsics/rdtsc?view=vs-2019
//  gcc -o fda pgmtolist.c pgmfiles.c diff2d.c main.c -lm
//  .\fda.exe lena_noise_input.pgm lena_noise_output.pgm

#define FREQ_CPU 3500000000

void main (int argc, char **argv) {
  char   row[80];
  float  **matrix;
  int i, j;
  FILE   *inimage, *outimage;
  long   imax;
  int result;
  eightBitPGMImage *PGMImage;


  /* ---- variaveis para temporizacao  ---- */

  clock_t tempo;  // variavel para controle de tempo
  double tempoExecucao_ciclos, tempoExecucao = 0; // tempos de execução (clock() e rdtsc())
  unsigned long long quantCiclos; // contagem de ciclos 
  float  lambda; // Setting ID: 7, 15 ou 30
  float *lut = (float*) malloc(256 * sizeof(float));

  /* ---- define os valores para calculo FDA  ---- */
  printf("contrast paramter lambda (>0) : ");
  scanf("%f", &lambda);
  printf("number of iterations: ");
  scanf("%ld", &imax);

  LUT(lut, lambda); // com lambda definido, utiliza-o para calculo se usuario assim desejar

  /* ---- read image name  ---- */
  
  PGMImage = (eightBitPGMImage *) malloc(sizeof(eightBitPGMImage));
  strcpy(PGMImage->fileName, argv[1]);  // parâmetro já definido na hora de execucao

  tempo = clock();         // inicia contagem de tempo
  quantCiclos = __rdtsc(); // inicia contagem de ciclos da CPU

  result = read8bitPGM(PGMImage);

  tempo = clock() - tempo;                // atualiza tempo em segundos
  quantCiclos = __rdtsc() - quantCiclos ; // atualiza numero de ciclos

  tempoExecucao = ((double)tempo)/CLOCKS_PER_SEC;       // retorna o tempo em segundos
  tempoExecucao_ciclos = (double)quantCiclos/FREQ_CPU;  // tempoCiclo = (1/freq_cpu) * quantCiclos

  printf("read8bitPGM(): %f segundos por contagem de ciclos \n", tempoExecucao_ciclos);
  printf("read8bitPGM(): %f segundos \n", tempoExecucao);
  
  if(result < 0) 
    {
      printPGMFileError(result);
      exit(result);
    }

  /* ---- allocate storage for matrix ---- */
  
  matrix = (float **) malloc (PGMImage->x * sizeof(float *));
  if (matrix == NULL)
    { 
      printf("not enough storage available\n");
      exit(1);
    } 
  for (i=0; i<PGMImage->x; i++)
    {
      matrix[i] = (float *) malloc (PGMImage->y * sizeof(float));
      if (matrix[i] == NULL)
        { 
          printf("not enough storage available\n");
          exit(1);
        }
    }
  
  /* ---- read image data into matrix ---- */
  
 for (i=0; i<PGMImage->x; i++){
    for (j=0; j<PGMImage->y; j++){
      matrix[i][j] = (float) *(PGMImage->imageData + (i*PGMImage->y) + j); 
    }
 }

  /* ---- process image ---- */
  // Com os valores de processamento ja definidos, realiza o calculo FDA
  char op;
  printf("Deseja utilizar LUT? (S/N): ");
  scanf(" %c", &op);
  if(op == 'S'){
    tempo = clock();         // inicia contagem de tempo
    quantCiclos = __rdtsc(); // inicia contagem de ciclos da CPU
    for (i=1; i<=imax; i++)
    {
      printf("iteration number: %3ld \n", i);
      diff2d_2 (PGMImage->x, PGMImage->y, matrix, lut); // funcao criada para calculo com LUT
    }    
    tempo = clock() - tempo;                // atualiza tempo em segundos
    quantCiclos = __rdtsc() - quantCiclos;  // atualiza numero de ciclos

  }else{
    tempo = clock();         // inicia contagem de tempo
    quantCiclos = __rdtsc(); // inicia contagem de ciclos da CPU

    for (i=1; i<=imax; i++)
      {
        printf("iteration number: %3ld \n", i);
        diff2d (0.5, lambda, PGMImage->x, PGMImage->y, matrix); 
      }
    tempo = clock() - tempo;                // atualiza tempo em segundos
    quantCiclos = __rdtsc() - quantCiclos;  // atualiza numero de ciclos
  }

  tempoExecucao = ((double)tempo)/CLOCKS_PER_SEC;       // retorna o tempo em segundos
  tempoExecucao_ciclos = (double)quantCiclos/FREQ_CPU;  // tempoCiclo = (1/freq_cpu) * quantCiclos

  printf("diff2d(): %f segundos por contagem de ciclos \n", tempoExecucao_ciclos);
  printf("diff2d(): %f segundos \n", tempoExecucao);
  
  /* copy the Result Image to PGM Image/File structure */

  for (i=0; i<PGMImage->x; i++){
    for (j=0; j<PGMImage->y; j++){
      *(PGMImage->imageData + i*PGMImage->y + j) = (char) matrix[i][j];
    }
  }

  /* ---- write image ---- */
  
  strcpy(PGMImage->fileName, argv[2]); // argumento ja inicailizado como parametro

  tempo = clock();        // inicia contagem de tempo
  quantCiclos = __rdtsc(); // inicia contagem de ciclos da CPU

  write8bitPGM(PGMImage);

  tempo = clock() - tempo;                // atualiza tempo em segundos
  quantCiclos = __rdtsc() - quantCiclos ; // atualiza numero de ciclos

  tempoExecucao = ((double)tempo)/CLOCKS_PER_SEC;       // retorna o tempo em segundos
  tempoExecucao_ciclos = (double)quantCiclos/FREQ_CPU;  // tempoCiclo = (1/freq_cpu) * quantCiclos

  printf("write8bitPGM(): %f segundos por contagem de ciclos \n", tempoExecucao_ciclos);
  printf("write8bitPGM(): %f segundos \n", tempoExecucao);

  /* ---- disallocate storage ---- */
  
  for (i=0; i<PGMImage->x; i++)
    free(matrix[i]);
  free(matrix);

  free(PGMImage->imageData);
  free(PGMImage);
}


