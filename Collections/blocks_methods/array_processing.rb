class ArrayProcessing
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

  def array
    @array
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

    max_elements = []  # Массив для хранения максимальных элементов
    max_values = []    # Массив для хранения значений блока

    @array.each do |element|
      value = yield(element)

      if max_elements.size < n
        # Если в массиве еще недостаточно элементов
        max_elements << element
        max_values << value
      else
        # Если массив уже полон, находим минимальное значение среди сохраненных
        min_value = max_values.first
        min_index = 0

        # Находим минимальное значение в max_values и его индекс
        max_values.each_with_index do |v, i|
          if v < min_value
            min_value = v
            min_index = i
          end
        end

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
      # Сортируем элементы по значениям, но без использования sort
      result = []
      n.times do
        # Находим максимальный элемент вручную
        max_value = max_values.first
        max_index = 0
        max_values.each_with_index do |v, i|
          if v > max_value
            max_value = v
            max_index = i
          end
        end
        result << max_elements.delete_at(max_index)
        max_values.delete_at(max_index)
      end
      result
    end
  end

  # Реализация sort_by
  def sort_by
    return enum_for(:sort_by) unless block_given?

    result = []
    @array.each do |element|
      result << [yield(element), element]  # Массив пар [значение, элемент]
    end

    # Сортируем массив пар вручную
    n = result.length
    (n - 1).times do |i|
      (n - i - 1).times do |j|
        if result[j][0] > result[j + 1][0]
          result[j], result[j + 1] = result[j + 1], result[j]  # Меняем местами
        end
      end
    end

  # Возвращаем только элементы после сортировки без использования map
    sorted_elements = []
    result.each do |pair|
      sorted_elements << pair[1]  # Добавляем только элементы из пар
    end

    sorted_elements
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