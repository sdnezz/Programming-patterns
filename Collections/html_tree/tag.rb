class Tag
  attr_accessor :title_tag, :attributes_dictionary, :content_tag, :children, :parent

  def initialize(title_tag:, attributes_dictionary: nil, content_tag: nil, parent: nil)
    @title_tag = title_tag
    @attributes_dictionary = attributes_dictionary || {}
    @content_tag = content_tag
    @parent = parent
    @children = []
  end
  
  # Метод для проверки наличия дочерних элементов
  def has_children?
    !@children.empty?
  end

  # Строковое представление тега
  def to_s
    "<#{@title_tag} #{attributes_to_s}>#{@content_tag}</#{@title_tag}>"
  end

  private

  def attributes_to_s
    @attributes_dictionary.map { |k, v| "#{k}='#{v}'" }.join(" ")
  end
end