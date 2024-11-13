require_relative 'tag'
require_relative 'parser_html'
class HtmlTree
  attr_accessor :root

  def initialize(html_string)
    # Парсим HTML-строку и получаем массив хэшей тегов
    hash_tags = ParserHtml.parsing_html(html_string)
    # Берем первый тег как корневой
    root_tag = hash_tags[0]
    # Создаем корневой элемент дерева на основе информации из root_tag
    self.root = Tag.new(
      title_tag: root_tag[:title_tag],
      attributes_dictionary: root_tag[:attributes_dictionary],
      content_tag: root_tag[:content_tag]
    )
  end
end