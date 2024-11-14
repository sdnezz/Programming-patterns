require_relative 'tag'
require_relative 'parser_html'

class HTML_Tree
  include HTML_Parser

  attr_accessor :root, :tag_stack

  # Определяем переменную класса для void-тегов
  @@void_tags = %w[area base br col embed hr img input link meta param source track wbr]

  def initialize(html_string)
    hash_tags = HTML_Parser.parsing_html(html_string)
    root_tag = hash_tags[0]
    self.root = Tag.new(
      title_tag: root_tag[:title_tag],
      attributes_dictionary: root_tag[:attributes_dictionary],
      content_tag: root_tag[:content_tag]
    )
    self.tag_stack = [self.root]
    build_tree(self.root, hash_tags, 1)
  end

  def self.create_from_file(filepath)
    html_string = HTML_Parser.read_html_from_file(filepath)
    new(html_string)
  end

  def build_tree(parent, hash_tags, i)
    return if i >= hash_tags.size

    tag_data = hash_tags[i]
    if is_tag_void?(tag_data[:title_tag])
      parent.children << Tag.new(
        title_tag: tag_data[:title_tag],
        attributes_dictionary: tag_data[:attributes_dictionary],
        content_tag: ''
      )
      build_tree(parent, hash_tags, i + 1)
    elsif is_tag_closing?(tag_stack.last, tag_data[:title_tag])
      tag_stack.pop
      build_tree(tag_stack.last, hash_tags, i + 1)
    else
      new_tag = Tag.new(
        title_tag: tag_data[:title_tag],
        attributes_dictionary: tag_data[:attributes_dictionary],
        content_tag: tag_data[:content_tag]
      )
      parent.children << new_tag
      tag_stack.push(new_tag)
      build_tree(new_tag, hash_tags, i + 1)
    end
  end

  def is_tag_closing?(open_tag, close_tag)
    open_tag.title_tag == close_tag.sub('/', '')
  end

  def is_tag_void?(tag)
    @@void_tags.include?(tag)
  end
end
