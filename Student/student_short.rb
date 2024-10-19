require_relative 'person'
#Наследуемый класс с краткой информацией
class StudentShort < Person
  attr_reader :last_name_initials

  # Конструктор принимает объект класса Student и инициализирует только нужные поля
  def initialize(student)
    @last_name_initials = student.short_name  # Инициализируем инициалы с помощью метода short_name
    super(
      first_name: student.first_name,
      last_name: student.last_name,
      middle_name: student.middle_name,
      id: student.id,
      git: student.git,
      contact: student.contact
    )
  end

  def to_s
    str = []
    str << "ID: #{@id}" if @id
    str << "Фамилия И.О.: #{@last_name_initials}"
    str << "GitHub: #{@git}" if @git
    str << "#{@contacts}" if @contacts
    str.join("; ")
  end
end