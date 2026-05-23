# Exercício de programação linear

## Problema

Uma empresa metalomecânica decidiu abandonar a produção de alguns produtos não lucrativos da sua gama de fabrico. Esta decisão conduz à existência de excesso de
capacidade de produção em algumas secções da fábrica, que a administração pensa utilizar para produzir três novos produtos (P1, P2, e P3) mais rentáveis. A capacidade disponível em cada uma das três secções que podem limitar a produção destes produtos é dada na tabela seguinte:

| Secção     | Disp. (h/sem) |
|:-----------|:-------------:|
| Frezadoras | 500           |
| Tornos     | 350           |
| Furadoras  | 150           |

O número de horas necessárias, em cada secção, para produzir uma unidade de cada um
dos produtos apresenta-se na seguinte tabela:

| Secção     |  P1  |  P2  |  P3  |
|:-----------|:----:|:----:|:----:|
| Frezadoras | 9    | 3    | 5    |
| Tornos     | 5    | 4    | 0    |
| Furadoras  | 3    | 0    | 2    |

O departamento de vendas prevê que a procura dos produtos P1 e P3 excede a capacidade de produção destes produtos e que a procura semanal do produto P2 é de 20 unidades. O lucro unitário é de 33 u.m., 12 u.m. e 19 u.m., respectivamente, para os produtos P1, P2 e P3.

Formule este problema, como um problema de programação linear de modo a determinar qual o número de unidades a fabricar semanalmente de cada um dos produtos, por forma a maximizar o lucro.

## Resolução

### Apresentação dos dados

...

### Variáveis de decisão

$x_1$ = número de unidade de produção de P1 por semana  
$x_2$ = número de unidade de produção de P2 por semana  
$x_3$ = número de unidade de produção de P3 por semana

### Função problema

$$
\begin{aligned}
\text{Max}\ \mathbb{Z}=33x_1 + 12x_2 + 19x_3
\end{aligned}
$$

### Sujeito a

$$
\begin{aligned}
x_2 \le 20 \\
9x_1 + 3x_2 + 5x_3 \le 500 \\
5x_1 + 4x_2 \le 350 \\
3x_1 + 2x_3 \le 150 \\
x_1, x_2, x_3 \in \mathbb{R}^+
\end{aligned}
$$

## Solução ótima

A solução ótima estará em um dos vértices da região viável.

### Gráfico da solução

![grafico](pl01.jpg)

### Resultado

Aplicando a função objetivo em cada vértice, temos:

| Vértice | Função objetivo |
|:-------:|----------------:|
| (0,0)   | 0               |
| (0,180) | 7.200           |
| (60,0)  | 1.800           |

**Verifica-se que o melhor resultado está em se produzir, exclusivamente, 180 motoretas na Oficina 2.**
