require_relative 'student'
require 'date'
class TreeNode
  include Comparable
  include Enumerable
  attr_accessor :left, :right, :student

  def initialize(left: nil, right: nil, student:)
    self.student = student
    self.left = left
    self.right = right
  end

  # Переопределение оператора <=> для сравнения студентов по дате рождения
  def <=>(other)
    self.student <=> other.student
  end

  # Обход дерева: сначала узел, затем левое поддерево, правое поддерево (NLR)
  def each(&block)
    yield self
    left.each(&block) if left
    right.each(&block) if right
  end

  def to_s
    student.to_s
  end
end