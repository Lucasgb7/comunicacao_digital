#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "diff2d.h"



/*--------------------------------------------------------------------------*/
// LookUp Table (LUT): tabela de consultas
void LUT(float *lut, float lambda){    
    float tau =0.5;
    float result = 0.0, temp_result = 0.0;  // variaveis de resultado
    int i;
    for(i = 0; i<256; i++){ 
        temp_result = (float)fabs(i);       // converter para float
        temp_result = pow(temp_result,0.2); // (temp_result)^0.2 = raiz quinta
        temp_result = temp_result/lambda;   // obtem resultado da divisao do expoente
        if(temp_result != 0.0){
            temp_result = -(temp_result/5.0);   // caso resultado != 0: finaliza o calculo dividindo por 5
        }
        result = exp(temp_result);
        // result = exp( - (pow(fabs(v-w),0.2)/lambda) / 5.0);

        lut[i] = (1.0 - exp(-8.0 * tau * result)) / 8.0;    //  calculo final
    }
    // for (i = 0; i < 256; i++)
    // {
    //     printf("lut[%d]: %f \n",i, lut[i]);
    // }
}

/*--------------------------------------------------------------------------*/

void diff2d_2
     (long     nx,        /* image dimension in x direction */
      long     ny,        /* image dimension in y direction */
      float    **f,
      float    *lut)
{


long    i, j;                                     /* loop variables */
float   qC, qN, qNE, qE, qSE, qS, qSW, qW, qNW;   /* weights */
float   **g;                                      /* work copy of f */


/* ---- allocate storage for g ---- */

g = (float **) malloc ((nx+2) * sizeof(float *));
if (g == NULL)
   {
     printf("not enough storage available\n");
     exit(1);
   }
for (i=0; i<=nx+1; i++)
    {
      g[i] = (float *) malloc ((ny+2) * sizeof(float));
      if (g[i] == NULL)
         {
           printf("not enough storage available\n");
           exit(1);
         }
    }


/* ---- copy f into g ---- */

for (i=1; i<=nx; i++)
 for (j=1; j<=ny; j++)
     g[i][j] = f[i-1][j-1];


/* ---- create dummy boundaries ---- */

for (i=1; i<=nx; i++)
    {
     g[i][0]    = g[i][1];
     g[i][ny+1] = g[i][ny];
    }

for (j=0; j<=ny+1; j++)
    {
     g[0][j]    = g[1][j];
     g[nx+1][j] = g[nx][j];
    }


/* ---- diffusive averaging ---- */
for (i=1; i<=nx; i++)
 for (j=1; j<=ny; j++)

     {
  
       /* calculate weights */

       qN  = lut[(int)fabs(g[i][j] - g[i  ][j+1])];
       qNE = lut[(int)fabs(g[i][j] - g[i+1][j+1])];
       qE  = lut[(int)fabs(g[i][j] - g[i+1][j  ])];
       qSE = lut[(int)fabs(g[i][j] - g[i+1][j-1])];
       qS  = lut[(int)fabs(g[i][j] - g[i  ][j-1])];
       qSW = lut[(int)fabs(g[i][j] - g[i-1][j-1])];
       qW  = lut[(int)fabs(g[i][j] - g[i-1][j  ])];
       qNW = lut[(int)fabs(g[i][j] - g[i-1][j+1])];
       qC  = 1.0 - qN - qNE - qE - qSE - qS - qSW - qW - qNW;
       

       /* weighted averaging */

       f[i-1][j-1] = qNW * g[i-1][j+1] + qN * g[i][j+1] + qNE * g[i+1][j+1] +
                     qW  * g[i-1][j  ] + qC * g[i][j  ] + qE  * g[i+1][j  ] +
                     qSW * g[i-1][j-1] + qS * g[i][j-1] + qSE * g[i+1][j-1];
        
     }  /* for */


/* ---- disallocate storage for g ---- */

for (i=0; i<=nx+1; i++)
    free(g[i]);
free(g);

return;

} /* diff */






/*--------------------------------------------------------------------------*/


float dco (float v,         /* value at one point */
           float w,         /* value at the other point */
           float lambda)    /* contrast parameter */

/* diffusivity */

{
    float result = 0.0, temp_result = 0.0;

    temp_result = (float)fabs(v-w);
    temp_result = pow(temp_result,0.2);
    temp_result = temp_result/lambda;
    if(temp_result != 0.0){
        temp_result = -(temp_result/5.0);
    }
    result = exp(temp_result);
    //result = exp( - (pow(fabs(v-w),0.2)/lambda) / 5.0);

    return (result);
}


/*--------------------------------------------------------------------------*/


void diff2d

     (float    ht,        /* time step size, >0, e.g. 0.5 */
      float    lambda,    /* contrast parameter */
      long     nx,        /* image dimension in x direction */
      long     ny,        /* image dimension in y direction */
      float    **f)       /* input: original image ;  output: smoothed */


/*--------------------------------------------------------------------------*/
/*                                                                          */
/*             NONLINEAR TWO DIMENSIONAL DIFFUSION FILTERING                */
/*                                                                          */
/*                       (Joachim Weickert, 7/1994)                         */
/*                                                                          */
/*--------------------------------------------------------------------------*/


/* Explicit scheme with 9-point stencil and exponential stabilization.      */
/* Conservative, conditionally consistent to the discrete integration       */
/* model, unconditionally stable, preserves maximum-minimum principle.      */


{

long    i, j;                                     /* loop variables */
float   qC, qN, qNE, qE, qSE, qS, qSW, qW, qNW;   /* weights */
float   **g;                                      /* work copy of f */


/* ---- allocate storage for g ---- */

g = (float **) malloc ((nx+2) * sizeof(float *));
if (g == NULL)
   {
     printf("not enough storage available\n");
     exit(1);
   }
for (i=0; i<=nx+1; i++)
    {
      g[i] = (float *) malloc ((ny+2) * sizeof(float));
      if (g[i] == NULL)
         {
           printf("not enough storage available\n");
           exit(1);
         }
    }


/* ---- copy f into g ---- */

for (i=1; i<=nx; i++)
 for (j=1; j<=ny; j++)
     g[i][j] = f[i-1][j-1];


/* ---- create dummy boundaries ---- */

for (i=1; i<=nx; i++)
    {
     g[i][0]    = g[i][1];
     g[i][ny+1] = g[i][ny];
    }

for (j=0; j<=ny+1; j++)
    {
     g[0][j]    = g[1][j];
     g[nx+1][j] = g[nx][j];
    }


/* ---- diffusive averaging ---- */
for (i=1; i<=nx; i++)
 for (j=1; j<=ny; j++)

     {
  
       /* calculate weights */

       qN  = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i  ][j+1], lambda))) / 8.0;
       qNE = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i+1][j+1], lambda))) / 8.0;
       qE  = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i+1][j  ], lambda))) / 8.0;
       qSE = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i+1][j-1], lambda))) / 8.0;
       qS  = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i  ][j-1], lambda))) / 8.0;
       qSW = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i-1][j-1], lambda))) / 8.0;
       qW  = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i-1][j  ], lambda))) / 8.0;
       qNW = (1.0 - exp(-8.0 * ht * dco(g[i][j], g[i-1][j+1], lambda))) / 8.0;
       qC  = 1.0 - qN - qNE - qE - qSE - qS - qSW - qW - qNW;


       /* weighted averaging */

       f[i-1][j-1] = qNW * g[i-1][j+1] + qN * g[i][j+1] + qNE * g[i+1][j+1] +
                     qW  * g[i-1][j  ] + qC * g[i][j  ] + qE  * g[i+1][j  ] +
                     qSW * g[i-1][j-1] + qS * g[i][j-1] + qSE * g[i+1][j-1];

     }  /* for */


/* ---- disallocate storage for g ---- */

for (i=0; i<=nx+1; i++)
    free(g[i]);
free(g);

return;

} /* diff */


/*--------------------------------------------------------------------------*/

