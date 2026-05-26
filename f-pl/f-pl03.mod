/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 23 de mai de 2026 at 21:49:26
 *********************************************/

//Uma fabrica produz dois produtos P1 e P2. A produção unitária de cada produto
//necessita de uma certa quantidade de horas de fabricação sobre cinco máquinas
//diferentes (A, B, C, D e E), como se pode verificar no quadro seguinte:
//
//Produto \ Máquina		|  A  |  B  |  C  |  D  |  E  |
//P1 									|  0  | 1.5 |  2  |  3  |  3  |
//P2 									|  3  |  4  |  3  |  2  |  0  |
//Disp. cada máquina	| 39h | 60h | 57h | 70h | 57h |
//
//As margens brutas unitárias de cada produto são: 6 € para o produto 1 e 15 € para o
//produto 2.
//Formular o programa linear que permite a determinação do plano de produção óptimo
//desta fábrica.

float production_time[1..2][1..5] = [
	[0, 1.5, 2, 3, 3],
	[3, 4, 3, 2, 0]
];

int available_time[1..5] = [39, 60, 57, 70, 57];

int multiplier_factor[1..2] = [6, 15];

dvar int+ x[1..2];

maximize sum(i in 1..2) multiplier_factor[i] * x[i];

subject to {
  forall (j in 1..5) {
    sum(i in 1..2) production_time[i][j] * x[i] <= available_time[j];
  }
}