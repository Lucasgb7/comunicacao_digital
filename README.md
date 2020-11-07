# Comunicação Digital

## QoS_TDM
### Projeto 1
Na redundância de hardware passiva os elementos redundantes são usados para
mascarar falhas. Todos os elementos executam a mesma tarefa e o resultado é
determinado por votação. Exemplos são TMR (triple modular redundancy) e NMR
(redundância modular com n módulos). TMR, redundância modular tripla, é uma
das técnicas mais conhecidas de tolerância a falhas. TMR máscara falhas em um
componente de hardware triplicando o componente e votando entre as saídas
para determinação do resultado. A votação pode ser por maioria (2 em 1) ou
votação por seleção do valor médio. O votador não tem a função de determinar
qual o módulo de hardware discorda da maioria. Se essa função for necessária no
sistema, ela deve ser realizada por um detector de falhas.
Baseado nessa descrição da técnica TMR, assuma que você é um desenvolvedor
que foi contratado pela empresa Videoflix S.A. que necessita implantar a técnica
de TMR no seu sistema de comunicação, mais precisamente no receptor, como
forma de oferecer QoS (Quality-of-Service), vendido para os seus clientes. A
empresa notou que a sua rede de comunicação possui muitos erros devido ao local
conter uma alta concentração de EMI, com a maior incidência sendo no meio de
comunicação. Diante disso, resolveu aplicar uma replicação de transmissão
(TMR), mas está querendo que seja implementado o mecanismo que
mitiga/mascará o erro. Sendo assim, você deve implementar o mecanismo de voto
para a seguinte configuração.

### Projeto 2
A empresa ABC S.A gostaria de implementar nos seus roteadores que estão sendo
desenvolvidos o mecanismo de TDM (Time Division Multiplexing), já que está
buscando reduzir o tamanho dos chips que a mesma vende e que são usadas nos
seus roteadores. Além disso, ela gostaria de um mecanismo que implemente essa
funcionalidade em nível de ciclo (com precisão) e optou por um hardware
dedicado, descrito em VHDL, como garantia. Sendo assim, você(s) foi(ram)
contrato(s) para implementar o TDM em hardware seguindo o projeto
demonstrado na imagem.

Está funcionalidade deve conseguir aplicar a técnica TDM corretamente e com o
máximo de automação possível. O hardware TDM deve receber 4 canais (usuários)
de entrada e dividir o tempo igualmente entre os eles. A empresa requisita que a
quantidade de tempo (ciclos) em que cada canal (usuário) recebe o canal de saída
seja o configurável. Além disso, é necessário haver um sinal de ready para cada
canal (usuário) de entrada saber quando o canal de saída está alocado para ele. 
