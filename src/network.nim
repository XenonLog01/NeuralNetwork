import math

type
  Layer*[NumIn, NumOut: static int] = object
    weights: matrix[NumOut, NumIn, float64]
    biases: vector[NumOut, float64]

proc calcOutputs*(layer: Layer, inputs: vector[layer.NumIn, float64]): vector[layer.NumOut, float64] =
  let
    z: vector[layer.NumOut,float64] = (inputs * layer.weights) + layer.biases #Weighted Sum
