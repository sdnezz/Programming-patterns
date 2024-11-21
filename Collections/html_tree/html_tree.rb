require_relative 'tag'
require_relative 'parser_html'
class HtmlTree
  include Enumerable

  attr_accessor :root, :tag_stack

  private :root=, :tag_stack=

  @@void_tags = %w[area base br col embed hr img input link meta param source track wbr]

  def initialize(html_string)
    hash_tags = ParserHtml.parsing_html(html_string)
    root_tag = hash_tags.shift
    self.root = Tag.new(
      title_tag: root_tag[:title_tag],
      attributes_dictionary: root_tag[:attributes_dictionary],
      content_tag: root_tag[:content_tag]
    )
    self.tag_stack = [self.root]
    build_tree(self.root, hash_tags)
  end

  def self.create_from_file(filepath)
    html_string = ParserHtml.read_html_from_file(filepath)
    new(html_string)
  end

  def build_tree(parent, hash_tags)
    hash_tags.each do |tag_data|
      if tag_data[:closing]
        # Закрывающий тег — возвращаемся к родителю
        self.tag_stack.pop
        parent = self.tag_stack.last
      elsif is_tag_void?(tag_data[:title_tag])
        # Void-тег
        parent.children << Tag.new(
          title_tag: tag_data[:title_tag],
          attributes_dictionary: tag_data[:attributes_dictionary],
          content_tag: nil
        )
      else
        # Обычный тег
        new_tag = Tag.new(
          title_tag: tag_data[:title_tag],
          attributes_dictionary: tag_data[:attributes_dictionary],
          content_tag: tag_data[:content_tag]
        )
        parent.children << new_tag
        new_tag.parent = parent
        self.tag_stack.push(new_tag)
        parent = new_tag
      end
    end
  end

  def is_tag_void?(tag)
    @@void_tags.include?(tag)
  end

  # Реализация each для работы с Enumerable
  def each(&block)
    dfs(@root, &block)
  end

  # Обход в глубину (DFS)
  def dfs(node, &block)
    return if node.nil?

    yield node
    node.children.each { |child| dfs(child, &block) }
  end

  # Обход в ширину (BFS)
  def bfs(&block)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      yield node
      queue.concat(node.children)
    end
  end

  # Отдельные методы для DFS и BFS
  def each_dfs(&block)
    dfs(@root, &block)
  end

  def each_bfs(&block)
    bfs(&block)
  end

  # Печать структуры дерева
  def print_tree(node = @root, indent = 0)
    return if node.nil?

    attr_str = node.attributes_dictionary.map { |key, value| "#{key}=\"#{value}\"" }.join(' ')
    attr_str = " #{attr_str}" unless attr_str.empty?
    content_preview = node.content_tag[0..20] + (node.content_tag.length > 20 ? "..." : "") if node.content_tag

    puts "#{' ' * indent}<#{node.title_tag}#{attr_str}> (children: #{node.children_count})"
    puts "#{' ' * (indent + 2)}Content: #{content_preview}" if content_preview

    node.children.each { |child| print_tree(child, indent + 2) }
    puts "#{' ' * indent}</#{node.title_tag}>"
  end
end