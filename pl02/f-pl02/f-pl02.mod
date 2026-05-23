/*********************************************
 * OPL 22.1.1.0 Model
 * Author: fabri
 * Creation Date: 23 de mai de 2026 at 19:55:18
 *********************************************/

// Time consumed at section i to produce product j
int production_time[1..3][1..3] = [
	[9, 3, 5],
	[5, 4, 0],
	[3, 0, 2]
];

// Time available at section
int available_time[1..3] = [500, 350, 150];

// Multiplier factor
int multiplier_factor[1..3] = [33, 12, 19];

// Decision variables: amount of product to produce
dvar int+ x[1..3];

// Objective
maximize
  	sum(i in 1..3) multiplier_factor[i]*x[i];

// Constraints
// x_2 \le 20 \\
// 9x_1 + 3x_2 + 5x_3 \le 500 \\
// 5x_1 + 4x_2 \le 350 \\
// 3x_1 + 2x_3 \le 150 \\
subject to {
  	x[2] <= 20;
	forall(i in 1..3) {
		sum(j in 1..3) production_time[i][j] * x[i] <= available_time[i];
	}
}