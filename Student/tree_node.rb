require_relative 'student'
class TreeNode
  attr_accessor :student, :left, :right

  def initialize(student)
    @student = student
    @left = nil
    @right = nil
  end

  # Реализация метода each для обхода дерева
  def each(&block)
    yield self
    left.each(&block) if left
    right.each(&block) if right
  end

  # Метод для красивого вывода информации об узле
  def to_s
    student.to_s
  end
end