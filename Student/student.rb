require_relative 'person'
require 'date'
class Student < Person
  
  include Comparable

  attr_reader :phone, :telegram, :email, :birthdate
  # Конструктор для студента
  def initialize(id: nil, first_name:, last_name:, middle_name:, git: nil, phone: nil, telegram: nil, email: nil, birthdate: nil)
    set_contacts(phone: phone, telegram: telegram, email: email)
    self.birthdate = birthdate if birthdate
    super(first_name: first_name, last_name: last_name, middle_name: middle_name, git: git, id: id, contact: contact_info)
  end

  # Сеттер для phone с валидацией
  private def phone=(phone)
	  if phone.nil? || Student.phone_valid?(phone)
	    @phone = phone
	  else
	    raise ArgumentError, "Неверный телефон: #{id} #{last_name} #{first_name}"
	  end
	end

  # Сеттер для telegram с валидацией
 	private def telegram=(telegram)
	  if telegram.nil? || Student.telegram_valid?(telegram)
	    @telegram = telegram
	  else
	    raise ArgumentError, "Неверный Telegram: #{id} #{last_name} #{first_name}"
	  end
	end

  private def email=(email)
	  if email.nil? || Student.email_valid?(email)
	    @email = email
	  else
	    raise ArgumentError, "Неверный адрес электронной почты: #{id} #{last_name} #{first_name}"
	  end
	end

  def birthdate=(birthdate)
    @birthdate = Date.parse(birthdate)
  end

  def self.create_from_hash(student_hash)
    Student.new(
      id: student_hash[:id],
      first_name: student_hash[:first_name],
      last_name: student_hash[:last_name],
      middle_name: student_hash[:middle_name],
      git: student_hash[:git],
      phone: student_hash[:phone],
      telegram: student_hash[:telegram],
      email: student_hash[:email],
      birthdate: student_hash[:birthdate]
    )
  end


  def <=>(other)
    if self.birthdate < other.birthdate
      return -1
    elsif self.birthdate == other.birthdate
      return 0
    else
      return 1
    end
  end

  def ==(other)
    if (!self.git.nil? && self.git == other.git) ||
      (!self.phone.nil? && self.phone == other.phone) ||
      (!self.email.nil? && self.email == other.email) ||
      (!self.telegram.nil? && self.telegram == other.telegram)
      return true
    else
      return false
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
	    nil
	  end
	end

  def get_info
    "#{short_name}; Гит: #{git_info}; #{@contact}"
  end

  def to_s
    str = []
    str << super
    str << "Номер телефона: #{@phone}" if @phone
    str << "Телеграм: #{@telegram}" if @telegram
    str << "Почта: #{@email}" if @email
    str << "Дата рождения: #{birthdate}" if @birthdate
    str.join("; ")
  end

  # Метод для создания краткой информации о студенте
  def short_info
    "id: #{@id}; Фамилия: #{@firstname}; Имя: #{@last_name}; Отчество: #{@middle_name}; git: #{@git}; #{@contact}"
  end
end