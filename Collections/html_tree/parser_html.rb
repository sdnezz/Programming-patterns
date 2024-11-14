module HTML_Parser
  def self.read_html_from_file(filepath)
    html_string = ""
    File.open(filepath, 'r') { |file| file.each_line { |line| html_string += line.strip } }
    html_string
  end

  def self.parsing_html(html_string)
    return nil if html_string.empty?
    hash_tags = []
    start_tags = (0...html_string.size).find_all { |i| html_string[i] == '<' }
    end_tags = (0...html_string.size).find_all { |i| html_string[i] == '>' }

    end_tags.each_with_index do |end_index, i|
      tag_info = html_string[end_tags[i] + 1...start_tags[i + 1]].strip if i + 1 < start_tags.size
      tag_string = html_string[start_tags[i]..end_tags[i]]
      tag_hash = get_hash_of_html_tag(tag_string, tag_info)
      hash_tags << tag_hash
    end
    hash_tags
  end

  def self.get_hash_of_html_tag(tag_string, content)
    tag_name, attributes = split_tag_name_and_attributes(tag_string[1..-2].strip)
    { title_tag: tag_name, attributes_dictionary: parse_attributes(attributes), content_tag: content, children: [] }
  end

  def self.split_tag_name_and_attributes(tag_string)
    parts = tag_string.split(' ', 2)
    [parts[0], parts[1] || ""]
  end

  def self.parse_attributes(attributes_string)
    attributes = {}
    attributes_string.scan(/(\w+)="([^"]*)"/) { |name, value| attributes[name.to_sym] = value }
    attributes
  end
end
