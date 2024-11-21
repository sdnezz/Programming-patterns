module ParserHtml
  def self.read_html_from_file(filepath)
    html_string = ""
    File.open(filepath, 'r') { |file| file.each_line { |line| html_string += line.strip } }
    html_string
  end

  def self.parsing_html(html_string)
    return [] if html_string.empty?

    tags = []
    html_string.scan(/(<\/?[^>]+>)([^<]*)/) do |tag, content|
      is_closing = tag.start_with?('</')
      tag_name, attributes = split_tag_name_and_attributes(tag.gsub(/[<\/>]/, '').strip)

      tags << {
        title_tag: tag_name,
        attributes_dictionary: is_closing ? {} : parse_attributes(attributes),
        content_tag: content.strip.empty? ? nil : content.strip,
        closing: is_closing
      }
    end
    tags
  end

  def self.split_tag_name_and_attributes(tag_string)
    parts = tag_string.split(' ', 2)
    [parts[0], parts[1] || ""]
  end

  def self.parse_attributes(attributes_string)
    attributes = {}
    attributes_string.scan(/(\w+)="([^"]*)"/) do |key, value|
      attributes[key.to_sym] = value
    end
    attributes
  end
end
