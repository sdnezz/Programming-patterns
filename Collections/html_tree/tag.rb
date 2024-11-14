class Tag
  include Comparable

  attr_accessor :children, :parent, :title_tag, :attributes_dictionary, :content_tag

  def initialize(title_tag:, attributes_dictionary: nil, content_tag: nil, children: nil, parent: nil)
    @title_tag = title_tag
    @attributes_dictionary = attributes_dictionary || {}
    @content_tag = content_tag
    @children = children || []
    @parent = parent
  end

  def <=>(other)
    title_tag <=> other.title_tag
  end

  # Обход в глубину
  def each_dfs(&block)
    yield self
    children.each { |node| node.each_dfs(&block) }
  end

  # Обход в ширину
  def each_bfs(&block)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      yield current_node
      queue.concat(current_node.children)
    end
  end

  # Проверка наличия атрибутов
  def has_attributes?
    !attributes_dictionary.empty?
  end

  # Количество дочерних элементов
  def children_count
    children.size
  end

  # Имя тега
  def tag_name
    title_tag
  end

  # Строковое представление тега
  def to_s
    "Tag: #{@title_tag} #{@attributes_dictionary} #{@content_tag}\n"
  end
end
