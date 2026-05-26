/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 09:25:11
 *********************************************/

// Suponha que uma dona de casa pretende servir à família um menu semanal em que
//entrem seis vegetais, tentando minimizar o custo, mas fornecendo o número de
//componentes necessários a uma alimentação equilibrada. Na tabela seguinte resumemse os factores envolvidos. 
// 
//| Vegetal                       | Ferro | Fósforo | Vit. A | Vit. B | Vit. C | Porção ($) |
//| ----------------------------- | ----- | ------- | ------ | ------ | ------ | ---------- |
//| Feijão verde                  | 0.45  | 10      | 415    | 8      | 0.3    | 50         |
//| Cenouras                      | 0.45  | 28      | 9065   | 3      | 0.35   | 50         |
//| Brócolos                      | 1.05  | 50      | 2550   | 53     | 0.6    | 80         |
//| Couves                        | 0.4   | 25      | 75     | 27     | 0.15   | 20         |
//| Nabos                         | 0.5   | 22      | 15     | 5      | 0.25   | 60         |
//| Batatas                       | 0.5   | 75      | 235    | 8      | 0.8    | 30         |
//| ----------------------------- | ----- | ------- | ------ | ------ | ------ | ---------- |
//| Necessidades semanais mínimas | 6     | 325     | 17500  | 245    | 5      | —          |
//
// Sabe-se ainda que não podem ser servidas mais do que duas porções de couve e mais do
//que quatro porções dos outros vegetais por semana.
//Formule o problema em termos de programação linear de modo a determinar o número
//de vezes que cada vegetal deve ser servido durante a próxima semana de forma a
//minimizar os custos e suprir as necessidades alimentares.

float nutritional[1..6][1..5] = [
	[0.45, 10, 415, 8, 0.3],
	[0.45, 28, 9065, 3, 0.35],
	[1.05, 50, 2550, 53, 0.6],
	[0.4, 25, 75, 27, 0.15],
	[0.5, 22, 15, 5, 0.25],
	[0.5, 75, 235, 8, 0.8]
];

int cost[1..6] = [50, 50, 80, 20, 60, 30];

float need[1..5] = [6.0, 325.0, 17500.0, 245.0, 5.0];

dvar int+ serving[1..6];

minimize
  sum(i in 1..6) serving[i] * cost[i];

subject to {
  forall(j in 1..5) {
    sum(i in 1..6) serving[i] * nutritional[i][j] >= need[j];
  }
  serving[1] <= 4;
  serving[2] <= 4;
  serving[3] <= 4;
  serving[4] <= 2;
  serving[5] <= 4;
  serving[6] <= 4;
}


string vegetables[1..6] = [
  "Feijao verde",
  "Cenouras",
  "Brocolos",
  "Couves",
  "Nabos",
  "Batatas"
];

string nutrients[1..5] = [
  "Ferro",
  "Fosforo",
  "Vitamina A",
  "Vitamina B",
  "Vitamina C"
];

execute {


  writeln("===== SOLUCAO OTIMA =====");

  writeln();
  writeln("Custo minimo = ", cplex.getObjValue());

  writeln();
  writeln("Porcoes por vegetal:");

  for(var i = 1; i <= 6; i++) {
    writeln(vegetables[i], " = ", serving[i]);
  }

  writeln();
  writeln("Nutrientes fornecidos:");

  for(var j = 1; j <= 5; j++) {

    var total = 0;

    for(var i = 1; i <= 6; i++) {
      total += serving[i] * nutritional[i][j];
    }

    writeln(nutrients[j], " = ", total);
  }
}