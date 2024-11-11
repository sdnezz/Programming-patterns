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

  # Реализация max_by
  def max_by
    return enum_for(:max_by) unless block_given?
    max_element = nil
    max_value = nil
    @array.each do |element|
      value = yield(element)
      if max_element.nil? || value > max_value
        max_element = element
        max_value = value
      end
    end
    max_element
  end

  # Реализация sort_by
  def sort_by
    return enum_for(:sort_by) unless block_given?
    @array.map { |element| [yield(element), element] }
          .sort { |a, b| a[0] <=> b[0] }
          .map { |pair| pair[1] }
  end

  # Реализация reject
  def reject
    return enum_for(:reject) unless block_given?
    result = []
    @array.each do |element|
      result << element unless yield(element)
    end
    result
  end
end