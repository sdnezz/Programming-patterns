require_relative 'tag'
class ParserHtml
  def self.parsing_html(html_string)
    # Возвращаем тестовый массив хэшей тегов, имитирующих результат парсинга
    [
      { title_tag: "html", attributes_dictionary: {}, content_tag: "" },
      { title_tag: "body", attributes_dictionary: {}, content_tag: "" },
    ]
  end
end
