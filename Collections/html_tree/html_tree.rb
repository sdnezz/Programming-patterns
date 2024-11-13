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
    # Построение дерева начиная с корневого элемента
    build_tree(self.root, hash_tags[1..-1])
  end

  # Метод для построения дерева с учетом вложенности
  def build_tree(current_tag, remaining_tags)
    while remaining_tags.any?
      tag_data = remaining_tags.shift
      new_tag = Tag.new(
        title_tag: tag_data[:title_tag],
        attributes_dictionary: tag_data[:attributes_dictionary],
        content_tag: tag_data[:content_tag]
      )

      # Проверка, является ли новый тег дочерним для текущего
      if is_child?(current_tag.title_tag, new_tag.title_tag)
        current_tag.children << new_tag  # Добавление дочернего тега
        build_tree(new_tag, remaining_tags)
      else
        # Если новый тег не является дочерним, возвращаем его для обработки на более высоком уровне
        remaining_tags.unshift(tag_data)
        return
      end
    end
  end

  # Пример проверки дочерности, здесь можно добавить логику, основанную на парсинге
  def is_child?(parent_tag, child_tag)
    # Условие для определения дочерности; в данном случае простая проверка
    parent_tag == "html" && child_tag == "body" ||
    parent_tag == "body" && child_tag == "p"
  end
end
