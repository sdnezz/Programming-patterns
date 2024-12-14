require_relative 'person'

class StudentShort < Person
  include Comparable

  # Конструктор для инициализации объекта
  def initialize(id:, git:, contact:, last_name_initials:)
    @id = id
    @git = git
    @contact = contact
    @last_name_initials = last_name_initials
  end

  # Метод для создания объекта на основе объекта student
  def self.new_from_student(student)
    self.new(
      id: student.id,
      git: student.git,
      contact: student.contact,
      last_name_initials: student.short_name
    )
  end

  # Метод для создания объекта на основе строки
  def self.new_from_string(id:, str:)
    student_short_init =   {}
    
    params = split_str_params(str)
    student_short_init[:id] = id
    student_short_init[:last_name_initials] = params[0]  # Инициалы из строки
    student_short_init[:git] = params[1]
    student_short_init[:contact] = params[2..].join(' ')  # Остальные контакты

    self.new(**student_short_init)
  end

  def self.split_str_params(str)
    str.split('; ')  # Разделяем строку по символу ";" c пробелом
  end
  # Закрываем метод new
  private_class_method  :new

  def <=>(other)
    return nil unless other.is_a?(StudentShort)
    self.id <=> other.id
  end
  
  # Переопределение метода to_s
  def to_s
    str = []
    str << "ID: #{@id}" if @id
    str << "Фамилия И.О.: #{@last_name_initials}"
    str << "GitHub: #{@git}" if @git
    str << "#{@contact}" if @contact
    str.join("; ")
  end
end
