/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 18:48:08
 *********************************************/

// Uma empresa pretende fabricar um novo produto e pretende contratar operadores de máquina. Sabe-se que os operadores de máquina se dividem em 3 categorias:
//especializado, não especializado e estagiário.
//Um operador especializado tem 10 anos de experiência e deve ser capaz de produzir 20 peças por dia das requeridas pela empresa. 
//Um operador não especializado tem 6 anos de experiência e deverá produzir 16 peças por dia. 
//Um operador estagiário tem 1 ano de experiência e deverá produzir 12 peças por dia.
//Devido a entraves legais, sabe-se ainda que pelo menos 30% dos operários a contratar têm de ser especializados 
// e que o número de estagiários a contratar deve ser pelo menos igual ao número de operários não especializados a contratar.
//Os salários, por dia, destes 3 tipos de operadores são, respectivamente, 8, 6 e 4 contos.
//Há no máximo 4 operadores especializados, 7 não especializados e 9 estagiários disponíveis para contratar. 
// Estão orçamentados 400 contos por semana (5 dias) para os salários dos operadores. 
// Por outro lado, a empresa pretende conseguir um nível mínimo total de 60 anos de experiência dos operadores contratados.
//A empresa pretende maximizar a produção diária.

string category [1..3] = [
	"Especializado",
	"Nao especializado",
	"Estagiario"
];

int experience [1..3] = [10, 6, 1];

// Production of pieces per day
int production [1..3] = [20, 16, 12];

// Salary per day
float salary [1..3] = [8.0, 6.0, 4.0];

// Availability per specialization
int availability [1..3] = [4, 7, 9];

//// Modeling

dvar int+ hire [1..3];

maximize
  sum (i in 1..3) hire[i] * production[i];

subject to {
  
  // minumum of 30% of specialized
  sum (i in 1..3) hire[i] * 0.3 <= hire[1];
  
  // trainee must be grater than or equal not specialized
  hire[2] <= hire[3];
 	
  // minimum of 60 years of experience
  sum (i in 1..3) hire[i] * experience[i] >= 60;
  
  // workforce availability
  forall (i in 1..3) {
    hire[i] <= availability[i];
  }
  
  // budget restriction 400 conto for 5 day = 80 conto / day
  sum (i in 1..3)	hire[i] * salary[i] <= 80;
  
}

// Presentation
execute {
    
  writeln(" SOLUCAO OTIMA ");
  
  var all = 0;
  for ( var x = 1; x <= 3; x++ ){
    all += hire[x];
  }
  
  writeln();
  writeln("-- Hired --");
  var total = 0;
  var payment = 0;
  var t_exp = 0;
  for ( var x = 1; x <= 3; x++ ) {
    total += hire[x] * production[x];
    payment += hire[x] * salary[x];
    t_exp += hire[x] * experience[x];
    writeln(category[x], " : ", hire[x], "(",hire[x]/all*100,"%)");
  }

  writeln();
  writeln("Best production: ", total);
  writeln("Payment:", payment);
  writeln("Years: ", t_exp);

}