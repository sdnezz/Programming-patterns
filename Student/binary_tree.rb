require_relative 'tree_node'
require 'date'

class BinarySortedTree
  include Enumerable

  attr_reader :root

  def initialize
    @root = nil
  end

  # Добавление студента в дерево
  def add(student)
    if @root.nil?
      @root = TreeNode.new(student)
    else
      insert(@root, student)
    end
  end

  # Метод вставки студента в дерево
  private def insert(node, student)
    if student.birthdate < node.student.birthdate
      if node.left.nil?
        node.left = TreeNode.new(student)
      else
        insert(node.left, student)
      end
    else
      if node.right.nil?
        node.right = TreeNode.new(student)
      else
        insert(node.right, student)
      end
    end
  end

  # Реализация метода each для интерфейса Enumerable
  def each(&block)
    traverse_in_order(@root, &block)
  end

  # Обход дерева в порядке возрастания (in-order traversal)
  private def traverse_in_order(node, &block)
    return if node.nil?

    traverse_in_order(node.left, &block)
    block.call(node.student)
    traverse_in_order(node.right, &block)
  end

  # Поиск студента по дате рождения
  def find_by_birthdate(birthdate)
    find(@root, Date.parse(birthdate))
  end

  private def find(node, birthdate)
    return nil if node.nil?

    if node.student.birthdate == birthdate
      node.student
    elsif birthdate < node.student.birthdate
      find(node.left, birthdate)
    else
      find(node.right, birthdate)
    end
  end
end