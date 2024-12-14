class DataTable
  attr_accessor :matrix
  private :matrix, :matrix=

  def initialize(matrix)
    self.matrix = matrix
  end
  def [](row_index, column_index)
    self.matrix[row_index][column_index]
  end
  def to_s
    self.matrix.map { |row| row.join(', ') }.join("\n")
  end
end