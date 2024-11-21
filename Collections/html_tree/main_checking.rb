require_relative 'tag'
require_relative 'parser_html'
require_relative 'html_tree'

# Загружаем HTML из файла
file_path = "example.html"

if File.exist?(file_path)
  tree = HtmlTree.create_from_file(file_path)

  # Вывод структуры дерева
  puts "=== Tree Structure ==="
  tree.print_tree

  # Использование Enumerable для DFS
  puts "\n=== Tags with Attributes (DFS using Enumerable) ==="
  tags_with_attributes = tree.select { |node| node.has_attributes? }
  tags_with_attributes.each do |node|
    puts "Tag: #{node.title_tag}, Attributes: #{node.attributes_dictionary}"
  end

  # Явный DFS
  puts "\n=== DFS (Manual Call) ==="
  tree.each_dfs do |node|
    puts "Tag: #{node.title_tag}, Attributes: #{node.attributes_dictionary}, Content: #{node.content_tag}"
  end

  # Явный BFS
  puts "\n=== BFS (Manual Call) ==="
  tree.each_bfs do |node|
    puts "Tag: #{node.title_tag}, Attributes: #{node.attributes_dictionary}, Content: #{node.content_tag}"
  end

else
  puts "File not found: #{file_path}"
end
