class Tag
  attr_accessor :title_tag, :attributes_dictionary, :content_tag, :children, :parent

  def initialize(title_tag:, attributes_dictionary: {}, content_tag: nil, children: [], parent: nil)
    @title_tag = title_tag
    @attributes_dictionary = attributes_dictionary
    @content_tag = content_tag
    @children = children
    @parent = parent
  end

  def has_attributes?
    !@attributes_dictionary.empty?
  end

  def children_count
    @children.size
  end

  def tag_name
    @title_tag
  end

  def to_s
    "<#{@title_tag} #{attributes_to_s}>#{@content_tag}</#{@title_tag}>"
  end

  private

  def attributes_to_s
    @attributes_dictionary.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
  end
end
