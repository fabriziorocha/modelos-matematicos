/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 27 de mai de 2026 at 12:08:03
 *********************************************/

// Considere que se pretende produzir dois bens A e B. Utilizam-se na produção duas
//matérias primas C e D. Para o efeito podem utilizar-se dois processos tecnológicos:

//1) para produzir 5 unidades de A e 2 unidades de B são necessárias 1 unidade  de C e 3 de D.
//2) para produzir 3 unidades de A e 8 unidades de B são necessárias 4 unidades de C e 2 de D.

//Sabe-se ainda que, durante o período de planeamento, dispomos de 100 unidades de “C” e de 150 unidades de “D”.
// Por outro lado, pretende-se produzir pelo menos 200 unidades de A e 75 de B.

//Pretende-se maximizar a produção de A+B durante o período de planeamento. 

//   string raw_material_name[1..2] = ["C", "D"]
int raw_material_availability[1..2] = [100, 150];

// Demand is for 200 units of product A and 75 units of product B
int product_demand[1..2] = [200, 75];

int process_input[1..2][1..2] = [
	[1, 3], // Process 1 consumes 1 unit  of raw material C and 3 units of raw material D
	[4, 2]  // Process 2 consumes 4 units of raw material C and 2 units of raw material D 
];

int process_output[1..2][1..2] = [
	[5, 2], // Process 1 produces 5 units of product A and 2 units of product B
	[3, 8]  // Process 2 produces 3 units of product A and 8 units of product B
];

dvar int+ n_process[1..2];

dexpr int material_c_consumption =
	sum(i in 1..2) n_process[i] * process_input[i][1];

dexpr int material_d_consumption =
	sum(i in 1..2) n_process[i] * process_input[i][2];
	
dexpr int product_a_production =
	sum(i in 1..2) n_process[i] * process_output[i][1];

dexpr int product_b_production =
	sum(i in 1..2) n_process[i] * process_output[i][2];

maximize
  product_a_production + product_b_production;

subject to {
  
  material_c_consumption <= raw_material_availability[1];
  
  material_d_consumption <= raw_material_availability[2];
  
  product_a_production >= product_demand[1];
  
  product_b_production >= product_demand[2];
  
};

execute {
  
  writeln("=== RESULTADO ===");
  
  writeln();
  writeln("O processo 1 foi executado ", n_process[1], " vezes.");
  writeln("O processo 2 foi executado ", n_process[2], " vezes.");
  
  writeln();
  writeln("--- Producao ---");
  var total_production_a = 0;
  var total_production_b = 0;
  for (var i = 1; i <= 2; i++) {
    var production_a = n_process[i] * process_output[i][1];
    var production_b = n_process[i] * process_output[i][2];
    total_production_a += production_a;
    total_production_b += production_b;
    writeln("O processo ", i, " produziu ", production_a, " unidade do produto A e ", production_b, " unidades do produto B.");
  };
  writeln("A producao total foi de ", total_production_a, " unidades do produto A e ", total_production_b, " unidades do produto B.");
  
  writeln();
  writeln("--- Consumo ---");
  var total_consumption_c = 0;
  var total_consumption_d = 0;
  for (var i = 1; i <= 2; i++) {
    var consumption_c = n_process[i] * process_input[i][1];
    var consumption_d = n_process[i] * process_input[i][2];
    total_consumption_c += consumption_c;
    total_consumption_d += consumption_d;
    writeln("O processo ", i, " consumiu ", consumption_c, " unidade do material C e ", consumption_d, " unidades do material D.");
  }
  writeln("O consumo total foi de ", total_consumption_c, " unidades do material C e ", total_consumption_d, " unidades do material D.");
  
}