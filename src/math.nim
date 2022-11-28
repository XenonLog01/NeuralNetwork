import std/math


#[
  Linear Algebra Operators
]#

type
  matrix*[X, Y: static int, T] = array[X, array[Y, T]]
  vector*[X: static int, T] = array[X, T]

proc `*`*[X, T](v1, v2: vector[X, T]): float64 = #Dot Product
  for i in v1.low .. v1.high:
    result += float64(v1[i] * v2[i])

proc `*`*[X, Y, Z, T](m1: matrix[X , Y, T], m2: matrix[Y,Z, T]): matrix[X,Z,T] = #Matrix Multiplication
  for i in result.low .. result.high:
    for j in result[0].low .. result[0].high:
      for k in m1[0].low .. m1[0].high:
        result[i][j] += m1[i][k] * m2[k][j]

proc `*`*[X, Y, T](v: vector[X, T], m: matrix[Y, X, T]): vector[Y, T] = #Vector Matrix Multiplication
  for i in m.low .. m.high:
    for j in m[0].low .. m[0].high:
      result[i] += v[j] * m[i][j]

proc `+`*[X, T](v1, v2: vector[X, T]): vector[X, T] = #Vector Addition
  for i in result.low .. result.high:
    result[i] = v1[i] + v2[i]


#[
  Rectifiers
]#

proc sigmoid*(x: float | int): float | int = 
  return 1/(1 + pow(E, float -x))

proc tanh*(x: float | int): float | int =
  return float64 (pow(E, float x) - pow(E, float -x))/(pow(E, float x) + pow(E, float -x))

proc relu*(x: float | int): float | int =
  if x <= 0: return 0
  else: return x

proc modRelu[T, I](x: T, rect: proc(x: T): I): I = #Takes in a rect function, returns a max with output func(x)
  if x <= 0: return 0
  else: return rect(x)

proc `>-`*[X: static int, T, I](a: vector[X, T], action: proc(x: T): I): vector[X, I] = #Applies a function to a vector
  for i, x in a:
    result[i] = action(x)


#[
  Other Functions
]#
proc getHighest*[X](a: vector[X, float | int]): float | int = 
  for x in a:
    if x > result: result = x