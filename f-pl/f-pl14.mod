/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 28 de mai de 2026 at 10:57:02
 *********************************************/

// Uma construtora possui um terreno de 9900 m2 onde pretende construir um conjunto
//de moradias. As moradias a construir nesse terreno são de 3 tipos: Tipos I, II e III. 

// Cada moradia de tipo I ocupa 170 m2 e permite obter um lucro de 3000 contos; 
// cada uma do tipo II ocupa 120 m2 e permite obter um lucro de 2000 contos; 
// e cada uma do tipo III ocupa 70 m2 e permite obter um lucro de 1000 contos.

//A empresa sabe que o projecto de urbanização será aprovado se e só se:
//* a área ocupada pelas moradias dos tipos I e II não for superior a 5100 m2,
//* forem construídas pelo menos 20 moradias do tipo III
//* forem reservados pelo menos 2000 m2 para jardins, vias e aparcamentos (os
//custos de construção destes serão suportados pela Câmara Municipal).

//O estudo de mercado efectuado mostra que todas as moradias construídas serão
//vendidas.
//Formule este problema de acordo com um modelo de programação linear. 

string TYPE_I		= "Tipo I";
string TYPE_II	= "Tipo II";
string TYPE_III	= "Tipo III";


float total_area        = 9900.0;
float preservation_area = 2000.0;
float construction_area = total_area - preservation_area;

tuple ResidentialKind {
  string name;
  float area;
  float profit;
};

{ResidentialKind} residential_kind = {
  <TYPE_I  , 170.0, 3000.0>,
  <TYPE_II , 120.0, 2000.0>,
  <TYPE_III,  70.0, 1000.0>
};

dvar int+ n_residential[residential_kind];

maximize
  sum(r in residential_kind) n_residential[r] * r.profit;
  
subject to {
  
  sum(r in residential_kind : r.name != TYPE_III) n_residential[r] * r.area <= 5100.00;
  sum(r in residential_kind : r.name == TYPE_III) n_residential[r] >= 20;
  sum(r in residential_kind) n_residential[r] * r.area <= construction_area;
  
}


execute {
  
  writeln("=== SOLUCAO OTIMA ===");
  writeln();
  
  var total_constructed_area = 0;
  var total_profit = 0;
  
  for (var r in residential_kind) {
    
    writeln("Serao construidas ", n_residential[r], " moradias do tipo ", r.name, ".");
    
    total_constructed_area += ( n_residential[r] * r.area );
    total_profit += ( n_residential[r] * r.profit	);
    
  }
  
  writeln();
  writeln("A area construida total eh de: ", total_constructed_area);
  writeln("E o lucro total eh de : ", total_profit);
  
}
