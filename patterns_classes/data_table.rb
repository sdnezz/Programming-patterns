class DataTable
  attr_accessor :matrix
  private :matrix, :matrix=

  def initialize(matrix)
    self.matrix = matrix
  end

  def [](row_index, column_index)
    self.matrix[row_index - 1][column_index - 1]
  end
  #По каждой row в строку и пробел
  def to_s
    self.matrix.map { |row| row.join(', ') }.join("\n")
  end

  def count_rows
    #Количество строк = количеству элементов вложенных во внешний массив
    self.matrix.size
  end
  def count_columns
    #Строка с максимальным количеством элементов - считаем сколько - колонки в матрице
    self.matrix.max{|a, b| a.size <=> b.size}.size
  end

end