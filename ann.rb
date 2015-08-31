class Perceptron
  def initialize(inputCount, weights, bias, analog)
    #inputCount is how many inputs the perceptron takes
    #weights are how important the respective inputs are to the output
    #bias has a positive correlation with how easy it is to fire
    #analog? is whether or not the perceptron can output decimal values
    @inputCount = inputCount
    @weights = weights
    @bias = bias
    @analog = analog
    if @inputCount != @weights.length
      Kernel.abort("Amount of inputs must equal the amount of weights")
    end
  end

  def output(inputs)
    if inputs.length != @inputCount
      Kernel.abort("Inputted vector doesn't match the length of input count")
    end
    weightedInputs = [] #this will be the input * the weight
    inputs.each_with_index do |a, i|
      weightedInputs[i] = inputs[i] * @weights[i]
    end
    summedWithBias = weightedInputs.reduce(:+) + @bias
    #if it's analog, use a bounding function like tanh
    #else, just make it a piecewise function
    if @analog
      return Math.tanh(summedWithBias)
    else
      return (summedWithBias > 0 ? 1 : -1)
    end
  end
end

class Network
  def initialize(layers)
    #layers is an array of the amount of neurons in each layer, from
    #the input layer to the output layer
    if layers.length < 2
      Kernel.abort("Neural network must have at least 2 layers")
    end

    @neurons = []
    layers.each_with_index do |neuronAmount, i|
      neuronAmout.times do |neuronCount|
        if i == 0 #if it's the first layer, the input layer
          @neurons[i][neuronCount] = Perceptron(1, [1], 0, true)
        else
          #make a random weighted neuron with inputs of all the neurons before it
          @neurons[i][neuronCount] = Perceptron(layers[i-1], Array.new(layers[i-1]){ rand }, rand, true)
        end
      end
    end
  end

  def feedForward(inputs) #feed the network input and see what comes out
