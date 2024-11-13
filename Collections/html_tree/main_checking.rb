require_relative 'html_tree'
require_relative 'parser_html'
require_relative 'tag'

# Пример HTML-строки для тестирования
html_string = "<html><body><p>Hello World</p></body></html>"

# Создание объекта HtmlTree на основе строки html_string
html_tree = HtmlTree.new(html_string)

# Вывод корневого тега и его атрибутов
puts "Root tag: #{html_tree.root.title_tag}"
puts "Root attributes: #{html_tree.root.attributes_dictionary}"
puts "Root content: #{html_tree.root.content_tag}"

# Проверяем, что у корня есть дочерние элементы и выводим их
puts "Root has children? #{html_tree.root.has_children?}"
html_tree.root.children.each do |child|
  puts "Child tag: #{child.title_tag}, Content: #{child.content_tag}"
end

# Вывод всего дерева (корень и его дочерние элементы)
puts "HTML Tree root to_s: #{html_tree.root}"
