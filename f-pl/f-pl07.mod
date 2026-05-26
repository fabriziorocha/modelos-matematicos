/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 13:07:18
 *********************************************/

// Um fabricante possui três fábricas, A, B e C que produzem 100, 120 e 120 toneladas de
//um determinado produto, respectivamente. O produto deverá ser entregue em cinco
//armazéns (1, 2, 3, 4 e 5), cada um dos quais deve receber a sua parte, 40, 50, 70, 90 e 90
//toneladas, respectivamente. Os custos, por tonelada, de transporte entre cada fábrica e
//cada armazém são dados na tabela seguinte:
//
//| Fábrica | Armazém 1 | Armazém 2 | Armazém 3 | Armazém 4 | Armazém 5 |
//| ------- | --------- | --------- | --------- | --------- | --------- |
//| A       | 4         | 1         | 2         | 6         | 9         |
//| B       | 6         | 4         | 3         | 5         | 7         |
//| C       | 5         | 2         | 6         | 4         | 8         |
//
//Formule o problema em termos de programação linear.

int fabric_capacity[1..3] = [100, 120, 120];

int storage_need[1..5] = [40, 50, 70, 90, 90];

int transportation_cost[1..3][1..5] = [
	[4, 1, 2, 6, 9],
	[6, 4, 3, 5, 7],
	[5, 2, 6, 4, 8]
];

dvar int+ transportation_amount[1..3][1..5];

minimize
  sum(i in 1..3, j in 1..5) transportation_amount[i][j] * transportation_cost[i][j];

subject to {
  
  forall(i in 1..3){
    sum(j in 1..5) transportation_amount[i][j] <= fabric_capacity[i];
  }
  
  forall(j in 1..5){
    sum(i in 1..3) transportation_amount[i][j] >= storage_need[j];
  }
}

string fabric[1..3] = ["Fabric A", "Fabric B", "Fabric C"];
int storage[1..5] = [0, 0, 0, 0, 0];

execute {
  
  writeln("=== SOLUCAO OTIMA===");
  
  writeln();
  writeln("Menor custo:", cplex.getObjValue());
  
  writeln();
  writeln("-- Quantidades transportadas --");
    
  writeln();
  for(var i = 1; i <= 3; i++){
    
    var total_fabric = 0;
    
    for(var j = 1; j <= 5; j++){
      
      total_fabric += transportation_amount[i][j];
      storage[j] += transportation_amount[i][j];
      
      if( j == 1 ){
        write(fabric[i]);
      }
      
      write(" ", transportation_amount[i][j]);
    
	    if ( j == 5 ){
	      writeln(" --- ", total_fabric);
    	}
      
    }
    
  }
  
  write("        ");
  for(var j = 1; j <= 5; j++){
    
    write(" ", storage[j]);
    
  }
  
}