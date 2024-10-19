require_relative 'person'
class Student < Person
  attr_reader :phone, :telegram, :email

  # Конструктор для студента
  def initialize(id: nil, first_name:, last_name:, middle_name:, git: nil, phone: nil, telegram: nil, email: nil)
    set_contacts(phone: phone, telegram: telegram, email: email)
    super(first_name: first_name, last_name: last_name, middle_name: middle_name, git: git, id: id, contact: contact_info)
  end

  # Сеттер для phone с валидацией
  def phone=(phone)
	  if phone.nil? || Student.phone_valid?(phone)
	    @phone = phone
	  else
	    raise ArgumentError.new("Неверный телефон: #{id} #{last_name} #{first_name}")
	  end
	end


  # Сеттер для telegram с валидацией
 	def telegram=(telegram)
	  if telegram.nil? || Student.telegram_valid?(telegram)
	    @telegram = telegram
	  else
	    raise ArgumentError.new("Неверный Telegram: #{id} #{last_name} #{first_name}")
	  end
	end

  private def email=(email)
	  if email.nil? || Student.email_valid?(email)
	    @email = email
	  else
	    raise ArgumentError.new("Неверный адрес электронной почты: #{id} #{last_name} #{first_name}")
	  end
	end


  # Метод для установки контактов через сеттеры
  def set_contacts(phone: nil, telegram: nil, email: nil)
    self.phone = phone if phone
    self.telegram = telegram if telegram
    self.email = email if email
    self.contact = contact_info
  end

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

  # Метод получения информации о контактах (исправил, теперь любой доступный)
	def contact_info
	  if @phone
	    "Телефон: #{@phone}"
	  elsif @telegram
	    "Телеграм: #{@telegram}"
	  elsif @email
	    "Почта: #{@email}"
	  else
	    "Ни один контакт не указан"
	  end
	end

  def get_info
    "#{short_name}; Git: #{git_info}; #{@contact}"
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


# разделить на файлы классы
# attr_reader - это метод, в student_short 'attr_reader: contacts' контактс это метод
# возвращающий контакт и в student 'contacts_info' метод тоже возращает contact. ОДИНАКОВЫЕ МЕТОДЫ, но разные названия
# validate_git_and_contact в student_short тоже хочет видеть
# заприватить или запротектить сеттеры телефон, емаил и тд.
# 