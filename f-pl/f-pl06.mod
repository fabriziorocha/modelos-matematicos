/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 11:49:35
 *********************************************/

// Pretende-se determinar a composição de uma ração para o gado. O alimento é obtido a
//partir de uma mistura de três produtos brutos: cevada, amendoim e sésamo. Para
//responder a certas exigências da clientela, o alimento deverá conter pelo menos 22% de
//proteínas e 3.6% de matéria gorda. No quadro abaixo, indicamos as quantidades de
//proteínas e de gorduras presentes respectivamente na cevada, no amendoim e no
//sésamo, bem como o custo, por tonelada, de cada um destes três produtos brutos.
//
//| Produto bruto      | Cevada | Amendoim | Sésamo |
//| ------------------ | ------ | -------- | ------ |
//| % de proteínas     | 22     | 52       | 42     |
//| % de gorduras      | 2      | 2        | 10     |
//| Custo por tonelada | 25     | 41       | 39     |
//
// Formular, sem resolver, o programa linear que permite a determinação da composição
//do alimento por forma a minimizar o custo de produção.

float nutritional[1..3][1..2] = [
	[0.22, 0.02],
	[0.52, 0.02],
	[0.42, 0.10]
];

float cost[1..3] = [25.00, 41.00, 39.00];

float demand[1..2] = [0.22, 0.036];

dvar float+ composition[1..3];

minimize
  sum(i in 1..3) composition[i] * cost[i];

subject to {
  sum(i in 1..3) composition[i] == 1;
  forall (j in 1..2) {
    sum (i in 1..3) nutritional[i][j] * composition[i] >= demand[j];
  }
}

string product[1..3] = [
	"Cevada",
	"Amendoim",
	"Sesamo"
];

string nutrient[1..2] = [
	"% de proteina",
	"% de gordura"
];

execute {
  
  writeln("=== SOLUCAO OTIMA ===\n");
  
  writeln("Custo minimo: ", cplex.getObjValue());
  
  writeln();
  writeln("--Composicao--");
  for (var i = 1; i <= 3; i++) {
    writeln(product[i], ": ", composition[i]);
  }
  
  writeln();
  writeln("--Fornece--");
  for (var j = 1; j <= 2; j++) {
    var total = 0;
	  for (var i = 1; i <= 3; i++) {
	    total += composition[i] * nutritional[i][j];
	  }
	  writeln(nutrient[j], ": ", total);
  }
}