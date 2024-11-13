class Tag
  attr_accessor :title_tag, :attributes_dictionary, :content_tag, :children, :parent

  def initialize(title_tag:, attributes_dictionary: nil, content_tag: nil, parent: nil)
    @title_tag = title_tag
    @attributes_dictionary = attributes_dictionary || {}
    @content_tag = content_tag
    @parent = parent
    @children = []
  end

  private
  def attributes_to_s
    @attributes_dictionary.map { |k, v| "#{k}='#{v}'" }.join(" ")
  end
end