/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 25 de mai de 2026 at 20:54:30
 *********************************************/

// Uma empresa produz apenas cómodas e armários.
// Cada cómoda é composta por uma estrutura base de cómoda, 3 gavetas grandes e 2 gavetas pequenas.
// Cada armário é composto por uma estrutura base de armário, 2 portas e 2 gavetas grandes (iguais às das cómodas).
//Cada componente dos moveis deve ser processada nas duas secções da empresa, estando os tempos de processamento indicados na tabela seguinte:
//
//| Produto                   | Secção 1 | Secção 2 |
//| ------------------------- | -------- | -------- |
//| Estrutura base de cómoda  | 6 h      | 4 h      |
//| Estrutura base de armário | 6 h      | 8 h      |
//| Gaveta grande             | 2 h      | 2 h      |
//| Gaveta pequena            | 1 h      | 2 h      |
//| Porta de armário          | 3 h      | 3 h      |
//| Tempo disponível          | 200 h    | 150 h    |
//
// O número de horas semanais disponíveis é de 200 para a secção 1 e 150 para a secção 2.
// Podem ser adquiridas mais horas de laboração para a secção 2, com um custo adicional de 1 u. m. por cada hora, e num máximo de 80 horas por semana.
// As gavetas podem ser compradas (em parte ou na totalidade) a uma outra empresa, implicando um custo adicional de 4 u.m. por gaveta grande e de 3 u.m. por gaveta pequena.
// O lucro obtido com cada cómoda é de 35 u.m., e o lucro obtido com cada armário é de 45 u.m..
// O objectivo da empresa é maximizar o lucro.
// Formule o problema segundo o modelo de programação linear, indicando o significado de cada variável e de cada restrição.

// Furniture description
string furniture[1..2] = [
	"Comoda",
	"Armario"
];

// Component description
//	string component[1..5] = [
//		"Estrutura base de comoda",
//		"Estrutura base de armario",
//		"Gaveta grande",
//		"Gaveta pequena",
//		"Porta de armario"
//	];

// Furniture assemblement
int furniture_component[1..2][1..5] = [
	[1, 0, 3, 2, 0],
	[0, 1, 2, 0, 2]
];

// Assemblement time component / section
int processing_time[1..5][1..2] = [
	[6, 4],
	[6, 8],
	[2, 2],
	[1, 2],
	[3, 3]
];

// Time available at section i in hours per week
float section_availability[1..2] = [200, 150];

// profit per 
int profit_multiplier[1..2] = [35, 45];

// Furniture assemblement time per section



dvar int+ furniture_production[1..2];
dvar int+ internal_big_drawer;
dvar int+ external_big_drawer;
dvar int+ internal_small_drawer;
dvar int+ external_small_drawer;
dvar int+ extra_labor;

maximize
  sum (i in 1..2) furniture_production[i] * profit_multiplier[i] - 1 * extra_labor - 4 * external_big_drawer - 3* external_small_drawer;


subject to {
  
  extra_labor <= 80;
  
	sum (f in 1..2) furniture_production[f] * furniture_component[f][3] == internal_big_drawer + external_big_drawer;  
	sum (f in 1..2) furniture_production[f] * furniture_component[f][4] == internal_small_drawer + external_small_drawer;  

	sum (f in 1..2) ( 
		furniture_production[f] * furniture_component[f][1] * processing_time[1][1]
		+ furniture_production[f] * furniture_component[f][2] * processing_time[2][1]
		+ furniture_production[f] * furniture_component[f][5] * processing_time[5][1]
	) 
	+ internal_big_drawer * processing_time[3][1]
	+ internal_small_drawer * processing_time[4][1] <= section_availability[1];

	sum (f in 1..2) ( 
		furniture_production[f] * furniture_component[f][1] * processing_time[1][2]
		+ furniture_production[f] * furniture_component[f][2] * processing_time[2][2]
		+ furniture_production[f] * furniture_component[f][5] * processing_time[5][2]
	) 
	+ internal_big_drawer * processing_time[3][2]
	+ internal_small_drawer * processing_time[4][2] <= section_availability[2] + extra_labor;
}
	
execute {
  
  writeln("Lucro maximo:", cplex.getObjValue());
  
  writeln();
  writeln("-- Producao --");
  for (var f = 1; f <= 2; f++) {
    writeln(furniture[f], ": ", furniture_production[f]);
  }
  
  writeln();
  writeln("-- Tempo por secao --");
  for (var s = 1; s <= 2; s++) {
    var total_section = 0;
    total_section += furniture_production[1] * furniture_component[1][1] * processing_time[1][s];
    total_section += furniture_production[1] * furniture_component[1][2] * processing_time[2][s];
    total_section +=                                 internal_big_drawer * processing_time[3][s];
    total_section +=                               internal_small_drawer * processing_time[4][s];
    total_section += furniture_production[1] * furniture_component[1][5] * processing_time[5][s];
    writeln("Secao ", s, ": ", total_section);
  }
  
  writeln();
  writeln("Horas extras contratadas: ", extra_labor);
}