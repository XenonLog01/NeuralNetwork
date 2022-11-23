type
  matrix*[X, Y: static int, T] = array[X, array[Y, T]]
  vector*[X: static int, T] = array[X, T]

proc `*`*[X, T](vec1, vec2: vector[X, T]): float64 = #Dot Product
  for i in vec1.low .. vec1.high:
    result += float64(vec1[i] * vec2[i])

proc `*`*[X, Y, Z, T](m1: matrix[X , Y, T], m2: matrix[Y,Z, T]): matrix[X,Z,T] = #Matrix Multiplication
  for i in result.low .. result.high:
    for j in result[0].low .. result[0].high:
      for k in m1[0].low .. m1[0].high:
        result[i][j] += m1[i][k] * m2[k][j]

proc `*`*[X, Y, T](v: vector[X, T], m: matrix[Y, X, T]): vector[Y, T] = #Vector Matrix Multiplication
  for i in m.low .. m.high:
    for j in m[0].low .. m[0].high:
      result[i] += v[j] * m[i][j]