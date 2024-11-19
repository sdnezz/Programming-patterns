require_relative 'person'
#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Person
  attr_reader :id, :first_name, :last_name, :middle_name, :git, :contact

  # Конструктор с общими полями для наследников, id,git и contact необязателен
  def initialize(id: nil, first_name:, last_name:, middle_name:, git: nil, contact: nil)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    self.git = git if git
    self.id = id if id
    self.contact = contact if contact
  end

  # Сеттер для first_name с валидацией
  def first_name=(value)
    validate_name(:first_name, value)
    @first_name = value
  end

  # Сеттер для last_name с валидацией
  def last_name=(value)
    validate_name(:last_name, value)
    @last_name = value
  end
  
  # Сеттер для middle_name с валидацией
  def middle_name=(value)
    validate_name(:middle_name, value)
    @middle_name = value
  end

  # Сеттер для id с валидацией
  def id=(value)
    raise ArgumentError, "Неверный ID: #{value}" unless Person.id_valid?(value)
    @id = value
  end

  # Сеттер для git с валидацией
  def git=(value)
    raise ArgumentError, "Неверный Git: #{value}" unless Person.git_valid?(value)
    @git = value
  end

  # Валидация имени, фамилии и отчества
  def validate_name(field, value)
    raise ArgumentError, "Неверное значение для #{field}: #{value}" unless Person.name_valid?(value)
  end

  # Предика для валидация имени, фамилии и отчества (capitalize)
  def self.name_valid?(name)
    name.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
  end

  # Валидация-предикат id
  def self.id_valid?(id)
    id.to_s.match?(/^\d+$/)
  end

  # Валидация-предикат ссылки на GitHub
  def self.git_valid?(git)
    git.match?(/^github\.com\/[\w.-]+$/)
  end

  def git_null?
    self.git.nil?
  end

  def contact_null?
    self.contact.nil?
  end

  protected def contact=(value)
    @contact = value
  end

  def validate_git_and_contact
    git_null? && contact_null?
  end

  # Метод для получения инициалов (Фамилия И.О.)
  def short_name
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
  end

  def git_info
    self.git
  end  

  def to_s
    str = []
    str << "ID: #{id}" if @id
    str << "Фамилия: #{last_name}"
    str << "Имя: #{first_name}"
    str << "Отчество: #{middle_name}"
    str << "GitHub: #{git}" if @git
    str.join("; ")
  end
end