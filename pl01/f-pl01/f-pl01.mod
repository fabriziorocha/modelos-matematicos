/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 23 de mai de 2026 at 18:41:34
 *********************************************/

// Time duration to produce i at garage j
int production_time[1..2][1..2] = [
 	[6, 3],
 	[4, 1]
];
 
// Amount of time available at garage j to produce any of i
int available_time[1..2] = [120, 180];

// Profit multiplier factor applied to each unit produced of i 
int profit_multiplier[1..2] = [30, 40];

// Decision variable: number of i to produce
dvar int+ x[1..2];

// Objective
maximize
	sum(i in 1..2) profit_multiplier[i] * x[i];


subject to {
	forall (j in 1..2) {
		sum(i in 1..2)	(production_time[i][j] * x[i]) <= available_time[j];
	}  	
}