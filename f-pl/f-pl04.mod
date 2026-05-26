/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 23 de mai de 2026 at 22:57:46
 *********************************************/

//Uma empresa de empacotamento (produção) de carnes pode produzir diariamente até
//480 presuntos, 400 salpicões e 230 lombos. Cada um destes produtos pode ser vendido
//fresco ou defumado. O total de presuntos, salpicões e lombos que podem ser defumados
//num dia de trabalho normal é de 420 unidades; todavia podem ainda ser defumados em
//horário extraordinário até um total de 250 unidades daqueles produtos. Os lucros
//líquidos unitários de vendas são os seguintes (em escudos)

// 									Defumado em horário
//					Fresco 	Normal 	Extraordinário
//Presunto	 800 		1400 		1100
//Salpicão	 400 		1200 		700
//Lombo 		 400 		1300 		900

//O objectivo é planear um esquema de produção (empacotamento) que maximize o lucro
//diário total, ou seja, saber quantos presuntos frescos e quantos defumados, quantos
//salpicões frescos e quantos defumados, quantos lombos frescos e quantos defumados se
//devem produzir diariamente por forma a maximizar a lucro total.
//Formule este problema de acordo com um modelo de programação linear.

int profit[1..3][1..3] = [
	[800, 1400, 1100],
	[400, 1200, 700],
	[400, 1300, 900]
];

int capacity[1..3] = [480, 400, 230];

dvar int+ production[1..3][1..3];

maximize 
	sum(i in 1..3, j in 1..3) production[i][j] * profit[i][j];

subject to {
  forall(i in 1..3){
  	sum(j in 1..3) production[i][j] <= capacity[i];
	}
  sum(i in 1..3) production[i][2] <= 420;
  sum(i in 1..3) production[i][3] <= 250;
}
