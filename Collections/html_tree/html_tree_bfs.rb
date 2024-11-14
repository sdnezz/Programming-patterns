require_relative 'html_tree'

class HTML_Tree_BFS < HTML_Tree
  include Enumerable

  def self.create_from_file(filepath)
    super(filepath)
  end

  def each(&block)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      yield node
      queue.concat(node.children)
    end
  end
end
