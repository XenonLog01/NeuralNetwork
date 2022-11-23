import math

type
  Layer*[InNodes, OutNodes: static int] = object
    weights: matrix[InNodes, OutNodes, float64]
    biases: vector[OutNodes, float64]

proc calcOutputs*(layer: Layer, inputs: array[layer.InNodes, float64]): vector[layer.OutNodes, float64] =
  var
    weightedInput: float64 = 0.0
    nodeOut = 0
    nodeIn = 0

  while nodeOut < layer.OutNodes:
    weightedInput = layer.biases[nodeOut]
    nodeIn = 0

    while nodeIn < layer.InNodes:
      weightedInput += inputs[nodeIn] * layer.weights[nodeIn, nodeOut]
      inc nodeIn

    result[nodeOut] = weightedInput
    inc nodeOut
