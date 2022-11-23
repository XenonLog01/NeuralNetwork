import std/math

type
  matrix*[X, Y: static int, T] = array[X, array[Y, T]]
  vector*[X: static int, T] = array[X, T]


#[
  Linear Algebra Operators
]#
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
  Math Functions
]#

proc sigmoid*(x: int): SomeNumber = 
  return float64 1/(1 + E^(-x))

proc tanh*(x: SomeNumber): SomeNumber =
  return float64 (E^x - E^(-x))/(E^x + E^(-x))

proc relu*(x: SomeNumber): SomeNumber =
  if x <= 0: return 0
  else: return x

proc modRelu*(x: SomeNumber, funct: proc): SomeNumber =
  if x <= 0: return 0
  else: return funct(x)

echo sigmoid(1)
