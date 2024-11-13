require_relative 'html_tree.rb'
require_relative 'parser_html'
require_relative 'tag.rb'

# Пример HTML-строки для тестирования
html_string = "<html><body><p>Hello World</p></body></html>"

# Создание объекта HtmlTree на основе строки html_string
html_tree = HtmlTree.new(html_string)

# Вывод корневого тега и его атрибутов
puts "Root tag: #{html_tree.root.title_tag}"
puts "Root attributes: #{html_tree.root.attributes_dictionary}"
puts "Root content: #{html_tree.root.content_tag}"