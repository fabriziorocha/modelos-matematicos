/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 28 de mai de 2026 at 21:31:09
 *********************************************/

// Pretende-se formar equipas de trabalho numa determinada empresa de construção
//naval. Um número total de quatro equipas deverá ser formado. Cada equipa contém
//apenas duas pessoas: um técnico e um operário. Para a constituição das equipas
//considera-se as afinidades existentes entre os operários e os técnicos. Assim, foi pedido
//a cada operário para atribuir uma nota de 0 a 5 (5 representando a melhor nota) a cada
//técnico. As notas são apresentadas no quadro seguinte:
//
//           a b c d
// Operário1 1 4 1 4
// Operário2 4 2 2 1
// Operário3 5 3 5 1
// Operário4 1 2 3 1

//Formular, sem resolver, o programa linear que permite a determinação das equipas de
//trabalho por forma a que a soma total das notas seja máxima. 

int survey[1..4][1..4] = [
	[1, 4, 1, 4],
	[4, 2, 2, 1],
	[5, 3, 5, 1],
	[1, 2, 3, 1]
];


dvar boolean team[1..4][1..4];

maximize
  sum(i in 1..4, j in 1..4) team[i][j] * survey[i][j];
  
subject to {
  
  forall(j in 1..4){
    sum(i in 1..4)	team[i][j] == 1;
  }
 
   forall(i in 1..4){
    sum(j in 1..4)	team[i][j] == 1;
  }
   
}


