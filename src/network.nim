import math

type
  Layer*[NumIn, NumOut: static int] = object
    weights: matrix[NumOut, NumIn, float64]
    biases: vector[NumOut, float64]

#[
  Forward Propogation
]#

proc calcOutputs*(layer: Layer, inputs: vector[layer.NumIn, float64]): vector[layer.NumOut, float64] =
  let
    z: vector[layer.NumOut,float64] = (inputs * layer.weights) + layer.biases #Weighted Sum
    a: vector[layer.NumbOUt, float64] = z >- sigmoid
  return a

proc forwardProp*[X: static int, Y](inputs: vector[X, float], layerLen: array[Y, static int]): vector[layerLen[-1], float] =
  var prevAct: vector = inputs
  for i, x in layerLen:
    var lyr = Layer(weights: new matrix[x, inputs.len], biases: new vector[x]) #Add Weights/Bias call function
    prevAct = calcOutputs(lyr, prevAct)
  return prevAct

proc getResult*[X, T](outs: vector[X, float], options: array[X, T]): T =
  return options[outs.find(getHighest(outs))]

#[
  Backpropogation
]#

proc error*[X, T](outs: vector[X, float], options: array[X, T], expected: float | int): float = 
  var expecteds: vector[X, int]
  for i in outs.low .. outs.high:
    if getResult(outs, options) == expected: expecteds[i] = 1
    else: expecteds[i] = 0 
  for i, x in outs:
    result += (x - expecteds[i])^2
  result = result/X