class RNN
  def initialize
    @h = [0, 0, 0]
    @W_xh = [rand, rand, rand] #input layer
    @W_hh = [rand, rand, rand] #hidden layer
    @W_hy = [rand, rand, rand] #output layer
  end
    
  def matrixMultiply(a, b)
    if a.length != b.length
      Kernel.abort("Different vector lengths")
    else
      return a.each_with_index.map { |x, i| x * b[i] }
    end
  end

  def matrixAdd(a, b)
    if a.length != b.length
      Kernel.abort("Different vector lengths")
    else
      return a.each_with_index.map { |x, i| x + b[i] }
    end
  end

  def step(x) #the goal here is to find the optimal W_xh, W_hh, and W_hy values to complete the problem
    @h = matrixAdd(matrixMultiply(@W_hh, @h), matrixMultiply(@W_xh, x)) #compute the hidden state
    @h.map! { |x| Math.tanh(x) } #bound the hidden state to [-1, 1]

    y = matrixMultiply(@W_hy, @h) #compute the output vector
    return y
  end
end

def charToVector
