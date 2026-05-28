/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 28 de mai de 2026 at 09:17:18
 *********************************************/

// Um criador de porcos pretende determinar as quantidades de cada tipo de ração que
//devem ser dadas diariamente a cada animal por forma a conseguir uma certa
//quantidade nutritiva a um custo mínimo.
//Os dados relativos ao custo de cada tipo de ração, às quantidades mínimas diárias de
//ingredientes nutritivos básicos a fornecer a cada animal, bem como às quantidades
//destes existentes em cada tipo de ração (g/Kg), constam do quadro a seguir 
 
//| Ingredientes Nutritivos | Granulado | Farinha | Quantidade mínima requerida |
//| ----------------------- | --------: | ------: | --------------------------: |
//| Carbohidratos           |        20 |      50 |                         200 |
//| Vitaminas               |        50 |      10 |                         150 |
//| Proteínas               |        30 |      30 |                         210 |
//| **Custo (Esc/Kg)**      |    **10** |   **5** |                             |
 
//Formule o problema de acordo com um modelo de programação linear, de modo a
//minimizar os custos. 

 tuple Feed {
   string name;
   int carbohydrate;
   int vitamin;
   int protein;
   float cost;
 }
 
 {Feed} feed = {
 	 <"Granulated", 20, 50, 30, 10.0>,
 	 <"Flour", 50, 10, 30, 5.0>
};

int    daily_need[1..3] = [200, 150, 210];

dvar float+ use_feed[feed];

minimize
  sum(f in feed) use_feed[f] * f.cost;

subject to {
  
  sum(f in feed) use_feed[f] * f.carbohydrate >= daily_need[1];
  sum(f in feed) use_feed[f] * f.vitamin >= daily_need[2];
  sum(f in feed) use_feed[f] * f.protein >= daily_need[3];
  
}

execute {
  
  writeln("=== SOLUCAO OTIMA ===");
  

	var total_cost = 0;
  var total_carbohydrate = 0;
  var total_vitamin = 0;
  var total_protein = 0;
  
  for (var f in feed){
    
  	writeln();
    writeln("Racao: ", f.name);
    writeln("Qtde: ", use_feed[f]);
    writeln("Carboidratos: ", use_feed[f] * f.carbohydrate);
    writeln("Vitaminas: ", use_feed[f] * f.vitamin);
    writeln("Proteinas: ", use_feed[f] * f.protein);
    
    total_cost += use_feed[f] * f.cost;
	  total_carbohydrate += use_feed[f] * f.carbohydrate;
	  total_vitamin += use_feed[f] * f.vitamin;
	  total_protein += use_feed[f] * f.protein;
    
  }
  
  writeln();
  writeln("Total de carboidratos: ", total_carbohydrate, "/", daily_need[1]);
  writeln("Total de vitaminas: ", total_vitamin, "/", daily_need[2]);
  writeln("Total de proteinas: ", total_protein, "/", daily_need[3]);
  
  writeln();
  writeln("Custo Total: ", total_cost);
  
}
