class ArrayProcessing
  attr_reader :array

  def initialize(array)
    self.array = array
  end

  def array=(array)
    if array.is_a?(Array)
      @array = array
    else
      raise TypeError.new('Неверный тип входных данных')
    end
  end

  private :array=

  # Реализация each_slice
  def each_slice(n)
    return enum_for(:each_slice, n) unless block_given?
    slice = []
    @array.each do |element|
      slice << element
      if slice.size == n
        yield slice
        slice = []
      end
    end
    yield slice unless slice.empty?
  end
end
