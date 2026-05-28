/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 26 de mai de 2026 at 17:34:07
 *********************************************/

// As existências actuais de tábuas numa fábrica de serração são constituídas por
// pranchas de madeira de 70 cm de comprimento. Esta fábrica tem uma encomenda de 50
// pranchas de 22 cm e 25 pranchas de 20 cm (todas as pranchas têm a mesma largura).
// Pretende-se satisfazer a encomenda por forma a minimizar o desperdício de madeira, o
// qual é constituído pelos restos e pelas pranchas produzidas a mais. Formule este
// problema como um problema de programação linear, interpretando claramente as
// variáveis de decisão, restrições e a função objectivo. 

int plank_demand[1..2] = [50, 25];
int plank_size[1..2] = [22, 20];

int pattern[1..4][1..3] = [
	[3, 0, 4],
	[2, 1, 6],
	[1, 2, 8],
	[0, 3, 10]
];

dvar int+ use_pattern[1..4];

dexpr int n_plank22 = 
	sum(i in 1..4) use_pattern[i] * pattern[i][1];

dexpr int n_plank20 = 
	sum(i in 1..4) use_pattern[i] * pattern[i][2];

minimize 
	sum(i in 1..4) use_pattern[i] * pattern[i][3] 
	+ ( n_plank22 - plank_demand[1] ) * plank_size[1]
	+ ( n_plank20 - plank_demand[2] ) * plank_size[2];

subject to {
  
  forall (d in 1..2) {
  	sum(i in 1..4) use_pattern[i] * pattern[i][d] >= plank_demand[d];
	}  
  
}

execute {
  
  var p22 = 0;
  var p20 = 0;
  var res = 0
  
  for (var i = 1; i <= 4; i++) {
    
    p22 += use_pattern[i] * pattern[i][1];
    p20 += use_pattern[i] * pattern[i][2];
    res += use_pattern[i] * pattern[i][3];
    
  }
  writeln("-- Desperdicio: ", res + ((p22 - plank_demand[1]) * plank_size[1]) + ((p20 - plank_demand[2]) * plank_size[2]));
  writeln("-- Pranchas com 22 cm: ", p22);
  writeln("-- Pranchas com 20 cm: ", p20);
  writeln();
  writeln("-- Foram produzidas ", (p22 - plank_demand[1]), " pranchas de 22 cm alem do pedido");
  writeln("-- Foram produzidas ", (p20 - plank_demand[2]), " pranchas de 20 cm alem do pedido");
  
}