#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Person
  attr_reader :id, :first_name, :last_name, :middle_name, :git

  # Конструктор с общими полями для наследников, id и git необязателен
  def initialize(id: nil, first_name:, last_name:, middle_name:, git: nil)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    self.git = git if git
    self.id = id if id
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

  # Метод для получения инициалов (Фамилия И.О.)
  def short_name
    "#{last_name} #{first_name[0]}.#{middle_name[0]}."
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

class Student < Person
  attr_reader :phone, :telegram, :email

  # Конструктор для студента
  def initialize(id: nil, first_name:, last_name:, middle_name:, git: nil, phone: nil, telegram: nil, email: nil)
    super(first_name: first_name, last_name: last_name, middle_name: middle_name, git: git, id: id)
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  # Сеттер для phone с валидацией
  def phone=(value)
    raise ArgumentError, "Неверный телефон: #{value}" unless Student.phone_valid?(value)
    @phone = value
  end

  # Сеттер для telegram с валидацией
  def telegram=(value)
    raise ArgumentError, "Неверный Telegram: #{value}" unless Student.telegram_valid?(value)
    @telegram = value
  end

  # Сеттер для email с валидацией
  def email=(value)
    raise ArgumentError, "Неверный email: #{value}" unless Student.email_valid?(value)
    @email = value
  end

  # Метод для установки контактов через сеттеры
  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
  end

  # Валидация телефонного номера
  def self.phone_valid?(phone)
    phone.to_s.match?(/^(\d{11}|\+\d{11})$/)
  end

  # Валидация телеги
  def self.telegram_valid?(telegram)
    telegram.match?(/^@[\w]+$/)
  end

  # Валидация электронной почты
  def self.email_valid?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def git_null?
    @git.nil?
  end

  def contacts_null?
    [@phone, @telegram, @email].nil?
  end

  def validate_git_and_contact
    git_null? && contacts_not_null?
  end
  # Метод получения информации о контактах (исправил, теперь любой доступный)
  def contacts_info
	  contacts = []
	  contacts << "Телефон: #{@phone}" if @phone
	  contacts << "Телеграм: #{@telegram}" if @telegram
	  contacts << "Почта: #{@email}" if @email
	  if contacts.empty?
	  	"Ни один контакт не указан"
	  else contacts.join(", ")
	  end
	end

  def git_info
    @git
  end

  def get_info
    "#{short_name}; Git: #{git_info}; #{contacts_info}"
  end

  def to_s
    str = []
    str << super
    str << "Номер телефона: #{@phone}" if @phone
    str << "Телеграм: #{@telegram}" if @telegram
    str << "Почта: #{@email}" if @email
    str.join("; ")
  end

  # Метод для создания краткой информации о студенте
  def short_info
    StudentShort.new(self)
  end
end

#Наследуемый класс с краткой информацией
class StudentShort < Person
  attr_reader :last_name_initials, :contacts

  # Конструктор принимает объект класса Student и инициализирует только нужные поля
  def initialize(student)
    @id = student.id if student.id
    @last_name_initials = student.short_name
    @git = student.git
    @contacts = student.contacts_info
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
