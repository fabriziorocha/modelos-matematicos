/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 16:43:14
 *********************************************/

// Uma empresa produz dois tipos diferentes (A e B) de fio de algodão. O fabrico de 100 Kg
//de fio do tipo A requer 2 h na secção de tinturaria e 1h na secção de fiação. A mesma
//quantidade de fio B requer 1.5h na secção de tinturaria e 2h na secção de fiação. As
//secções de tinturaria e fiação têm disponíveis diariamente 15h e 12 h respectivamente.
//Por imposição do mercado, a produção diária de fio A não deve ser inferior a 3000 Kg.
//Os lucros da venda de 100 Kg de fio são de 5 contos para o tipo A e de 10 contos para o
//tipo B. Pretende-se saber o plano de produção diário que maximize o lucro.

string type[1..2] = [
	"Algodao Tipo A", 
	"Algodao Tipo B"
];

string section[1..2] = [
	"Tinturaria", 
	"Fiacao"
];

// Production time of cotton type i by section j per 100kg
float production_time[1..2][1..2] = [
	[2.0, 1.0],
	[1.5, 2.0]
];

// Time constraint at section j
float section_limit[1..2] = [15.0, 12.0];

// Profit multiplier of cotton type i
int profit[1..2] = [5, 10];

// Decision variables, amount of cotton produced
dvar float+ production[1..2];

// Objective: maximize profit
maximize sum(i in 1..2) production[i] * profit[i];

// Constraints
subject to {
  
  production[1] >= 30.0;
  
  forall (j in 1..2) {
    sum (i in 1..2) production[i] * production_time[i][j] <= section_limit[j];
  }

}


// Presentation
execute {
  
  writeln("Best profit:", cplex.getObjValue());
  
  writeln();
  writeln("-- Production --");
  for ( var i = 1; i <= 2; i++ ) {
    writeln(type[i], ": ", production[i]);
  }
  
}

