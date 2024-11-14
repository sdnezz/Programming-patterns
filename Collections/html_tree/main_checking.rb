require './html_tree_dfs.rb'
require './html_tree_bfs.rb'

def main
  begin
    html_tree = HTML_Tree.create_from_file('example.html')
    p html_tree

    html_tree_dfs = HTML_Tree_DFS.create_from_file('example.html')
    html_tree_dfs.each { |node| puts "#{node}\n" }
    puts "Total nodes (DFS): #{html_tree_dfs.count}"

    html_tree_bfs = HTML_Tree_BFS.create_from_file('example.html')
    html_tree_bfs.each { |node| puts "#{node}\n" }

    puts "Nodes with no attributes (DFS): #{html_tree_dfs.count { |tag| tag.attributes_dictionary.empty? }}"
  rescue => error
    puts error
  end
end

main
