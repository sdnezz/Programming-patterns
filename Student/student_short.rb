class Student_short
  # Конструктор принимает либо объект класса Student, либо ID и строку с информацией
  def initialize(*args)
    if args.size == 1 && args[0].is_a?(Student)
      student = args[0]
      @id = student.id
      @last_name_initials = "#{student.last_name} #{student.first_name[0]}.#{student.middle_name[0]}."
      @git = student.git
      @contacts = student.contacts_info
    elsif args.size == 2
      @id = args[0]
      info_string = args[1]

      # Предполагается, что строка имеет формат "Фамилия И.О.; Git: ссылка; Связь: контакт"
      parts = info_string.split("; ")
      @last_name_initials = parts[0]
      @git = parts[1].gsub("Git: ", "")
      @contacts = parts[2].gsub("Контакты: ", "")
    else
      raise ArgumentError, "Неверные параметры конструктора"
    end
  end

  # Геттеры для полей
  attr_reader :id, :last_name_initials, :git, :contacts

  #Вывод информации об экземпляре
  def object_information
    puts "ID: #{@id}"
    puts "Фамилия И.О.: #{@last_name_initials}"
    puts "Контакты: #{@contacts}"
    puts "GitHub: #{@git}"
  end
end
