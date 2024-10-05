#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Student
	#Конструктор с хэшем параметров
  	def initialize(params = {})
    # fetch для обязательных полей (также сделали параметр id необязательным)
      @id = params[:id] if params[:id] && Student.id_valid?(params[:id])
      @last_name = if params[:last_name] && Student.name_valid?(params[:last_name])
                   	params[:last_name]
                 	 else
                   	raise ArgumentError, "Неверная фамилия: #{params[:last_name]}"
                 	 end
    	@first_name = if params[:first_name] && Student.name_valid?(params[:first_name])
                     params[:first_name]
                    else
                     raise ArgumentError, "Неверное имя: #{params[:first_name]}"
                    end
   		@middle_name =if params[:middle_name] && Student.name_valid?(params[:middle_name])
                    	params[:middle_name]
                    else
                     raise ArgumentError, "Неверное отчество: #{params[:middle_name]}"
                    end
    	@phone = params[:phone] if params[:phone] && Student.phone_valid?(params[:phone])
    	@telegram = params[:telegram] if params[:telegram] && Student.telegram_valid?(params[:telegram])        	
    	@email = params[:email] if params[:email] && Student.email_valid?(params[:email])
    	@git = params[:git] if params[:git] && Student.git_valid?(params[:git])
  	end

	#Автоматическое создание геттера и сеттера для каждого поля с помощью атрибута
	attr_accessor :id, :last_name, :first_name, :middle_name

	#Геттер для полей контактов
	attr_reader :phone, :telegram, :email, :git

	#Изменение полей контактов только через метод объекта а не его поля
	def set_contacts(params = {})
		# вызов метода проверки (валидации) на корректность телефона
  	@phone = params[:phone] if params[:phone] && Student.phone_valid?(params[:phone])
  	@telegram = params[:telegram] if params[:telegram] && Student.telegram_valid?(params[:telegram])
  	@email = params[:email] if params[:email] && Student.email_valid?(params[:email])
	end
	#Изменение поля гита только через метод объекта а не его поля
	def set_git(params = {})
		@git = params[:git] if params[:git] && Student.git_valid?(params[:git])
	end		

	#Метод для получения краткой информации о студенте
	def get_info
	  contact = if !@phone.nil?
	              "Телефон: #{@phone}"
	            elsif !@telegram.nil?
	              "Телеграм: #{@telegram}"
	            elsif !@contact.nil?
	              "Почта: #{@contact}"
	            else
	              "Контакты не указаны"
	            end
	  "#{short_name}; Git: #{git_info}; #{contact}"
	end

	#Метод получения информации о контактах
	def contacts_info
		"Контакты: #{phone} #{telegram} #{email}"
	end

	#Метод возвращающий git
	def git_info
		@git
	end

	def short_name
		"#{@last_name} #{first_name[0]}.#{middle_name[0]}."
	end	

	#Валидация для полей класса
	def self.id_valid?(id)
		id.to_s.match?(/^\d+$/)
  end
	# Валидация имени, фамилии и отчества (первая буква заглавная, остальные — строчные)
	def self.name_valid?(name)
  	name.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
	end

	# Валидация телефонного номера
	def self.phone_valid?(phone)
  	if phone.to_s.length == 11
    # регулярное выражение с проверкой на наличие последовательности цифр \d+
    	return phone.to_s.match?(/^\d+$/)
  	elsif phone.to_s.length == 12
    	# регулярное выражение с проверкой на наличие + и последовательности цифр \d+
    	return phone.to_s.match?(/^\+\d+$/)
  	else
    	return false
  	end
	end

	# Валидация Telegram-ника (может начинаться с @ и содержать только буквы, цифры и нижнее подчеркивание)
	def self.telegram_valid?(telegram)
  	telegram.match?(/^@[\w]+$/)
	end

	# Валидация электронной почты с использованием символов и домена)
	def self.email_valid?(email)
		email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

	# Валидация ссылки на GitHub - ссылка должна начинаться github.com/
	def self.git_valid?(git)
  	git.match?(/^github\.com\/[\w.-]+$/)
	end

	#Валидация в виде предиката на наличие гита
	def git_null?
		return @git.nil?
	end

	#Валидация с помощью предиката any? на наличие хотя бы одного контакта
	def contacts_null?
		[@phone, @telegram, @email].any? { |contact| contact != nil  }
	end

	#Метод для двух валидаций - наличия контакта и гита
	def validate_git_or_contact
	  errors = []

	  # Проверяем наличие Git
	  if git_null?
	    errors << "Гит не указан"
	  else
	    puts "Гит студента: #{@git}"
	  end

	  # Проверяем наличие хотя бы одного контакта
	  unless contacts_null?
	    errors << "Ни один контакт студента не указан"
	  else
	    puts "У студента есть хотя бы один контакт: #{contacts_info}"
	  end

	  # Если есть ошибки, выбрасываем исключение
	  raise ArgumentError, errors.join(", ") unless errors.empty?
	end

	#Метод класса для отображения текущего состояния объекта с помощью переопределения строки
	def to_s
  	str = []
  	str << "ID: #{@id}"
		str << "Фамилия: #{@last_name}"
		str << "Имя: #{@first_name}"
		str << "Отчество: #{@middle_name}"
		str << "Номер телефона: #{@phone}"
		str << "Телеграм: #{@telegram}"
		str << "Почта: #{@email}"
		str << "GitHub: #{@git}"
		str.join("; ")
  end

	#Метод для создания объекта-наследника суперкласса Student с краткой информацией
	def short_info
    StudentShort.new(self)
  end
end

#Наследуемый класс с краткой информацией
class StudentShort < Student
  # Конструктор принимает объект класса Student
  def initialize(student)
    @id = student.id
    @last_name_initials = student.short_name
    @git = student.git
    @contacts = student.contacts_info
  end

  # Геттеры для полей
  attr_reader :id, :last_name_initials, :git, :contacts

  # Вывод информации об экземпляре c помощью переопределения метода строки
  def to_s
  	str = []
  	str << "ID: #{@id}"
    str << "Фамилия И.О.: #{@last_name_initials}"
    str << "GitHub: #{@git}"
    str << "#{@contacts}"
    str.join("; ")
  end
end