require_relative 'tree_node'
require 'date'

class BinarySortedTree
  include Enumerable

  attr_accessor :root

  private :root=

  def initialize(obj_array)
    if obj_array.nil?
      raise ArgumentError.new('Неверный тип аргумента')
    end

    # Создание корня дерева с первым объектом
    self.root = TreeNode.new(left: nil, right: nil, student: obj_array[0])

    # Добавление всех остальных объектов в дерево
    obj_array[1..].each do |student|
      add_node(self.root, student)
    end
  end

  # Метод для добавления узлов в дерево
  def add_node(node, student)
    if student < node.student  # Сравниваем с текущим узлом
      if node.left.nil?
        node.left = TreeNode.new(left: nil, right: nil, student: student)
      else
        add_node(node.left, student)
      end
    else
      if node.right.nil?
        node.right = TreeNode.new(left: nil, right: nil, student: student)
      else
        add_node(node.right, student)
      end
    end
  end

  # Реализация метода each для обхода дерева
  def each(&block)
    self.root.each(&block)
  end

  # Вывод дерева
  def print_in_order(node)
    if !node.nil?
      puts node.student  # Сначала выводим текущий узел
      print_in_order(node.left)  # Рекурсивный обход левого поддерева
      print_in_order(node.right)  # Рекурсивный обход правого поддерева
    end
  end

  # Преобразование дерева в строку
  def to_s
    print_in_order(self.root)
  end
end