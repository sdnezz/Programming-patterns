require_relative 'html_tree'

class HTML_Tree_DFS < HTML_Tree
  include Enumerable

  def self.create_from_file(filepath)
    super(filepath)
  end

  def each(&block)
    dfs(@root, &block)
  end

  private

  def dfs(node, &block)
    yield node
    node.children.each { |child| dfs(child, &block) }
  end
end
