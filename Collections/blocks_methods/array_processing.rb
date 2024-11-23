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
    #Enumerator создается для метода each_slice по символу если не передан блок { }
    return enum_for(:each_slice, n) unless block_given?
    slice = []
    @array.each do |element|
      slice << element #в конец [1, element]
      if slice.size == n
        yield slice
        slice = []
      end
    end
    yield slice unless slice.empty?
  end

  # Реализация max_by
  def max_by(n = 1)
    return enum_for(:max_by, n) unless block_given?

    max_elements = [] # Массив для хранения максимальных элементов
    max_values = []   # Массив для хранения максимальных значений блока

    @array.each do |element|
      value = yield(element)

      if max_elements.size < n
        # Если в массиве еще недостаточно элементов
        max_elements << element
        max_values << value
      else
        # Если массив уже полон, ищем минимальное значение среди сохраненных
        min_value = max_values.min
        min_index = max_values.index(min_value)

        # Заменяем минимальный элемент, если текущий больше
        if value > min_value
          max_elements[min_index] = element
          max_values[min_index] = value
        end
      end
    end
    # Если n == 1, возвращаем единственный элемент, иначе массив
    if n == 1
      max_elements.first
    else
      #Объединение в массив пар из массивов значения и обработанного блоком значения по индексу
      max_elements.zip(max_values)
                  .sort_by { |_, value| -value }
                  .map { |element, _| element }
    end
  end

  # Реализация sort_by
  def sort_by
    return enum_for(:sort_by) unless block_given?
    @array.map { |element| [yield(element), element] }
          #Сравнение значения элементов из каждой пары возвращение самого элемента
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

  # Реализация cycle
  def cycle(n = nil)
    return enum_for(:cycle, n) unless block_given?
    cycles = 0
    loop do
      @array.each { |element| yield element }
      cycles += 1
      break if n && cycles >= n
    end
  end
end