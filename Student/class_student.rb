#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Student
	#Конструктор с хэшем параметров
  	def initialize(params = {})
    # fetch для обязательных полей (также сделали параметр id необязательным)
      @id = if params[:id] && Student.id_valid?(params[:id])
            	params[:id]
          	else
            	nil
          	end
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
    	#вызов метода проверки (валидации) на корректность телефона
    	@phone = if params[:phone] && Student.phone_valid?(params[:phone])
               	params[:phone]
             	 else
               	 nil
             	 end
    	@telegram = if params[:telegram] && Student.telegram_valid?(params[:telegram])
                  	params[:telegram]
                	else
                  	nil
                	end
    	@email = if params[:email] && Student.email_valid?(params[:email])
               	params[:email]
             	 else
               	 nil
             	 end
    	@git = if params[:git] && Student.git_valid?(params[:git])
             		params[:git]
           	 else
            	nil
           	 end
  	end

	#Автоматическое создание геттера и сеттера для каждого поля с помощью атрибута
	attr_accessor :id, :last_name, :first_name, :middle_name, :git

	#Геттер для полей контактов
	attr_reader :phone, :telegram, :email

	def set_contacts(params = {})
		# вызов метода проверки (валидации) на корректность телефона
  	@phone = params[:phone] if params[:phone] && Student.phone_valid?(params[:phone])
  	@telegram = params[:telegram] if params[:telegram] && Student.telegram_valid?(params[:telegram])
  	@email = params[:email] if params[:email] && Student.email_valid?(params[:email])
	end
	# Валидация телефонного номера
	def self.phone_valid?(phone)
  	if phone.length == 11
    # регулярное выражение с проверкой на наличие последовательности цифр \d+
    	return phone.match?(/^\d+$/)
  	elsif phone.length == 12
    	# регулярное выражение с проверкой на наличие + и последовательности цифр \d+
    	return phone.match?(/^\+\d+$/)
  	else
    	return false
  	end
	end

	def self.id_valid?(id)
		id.to_s.match?(/^\d+$/)
  end
	# Валидация имени, фамилии и отчества (первая буква заглавная, остальные — строчные)
	def self.name_valid?(name)
  	name.match?(/^[А-ЯЁA-Z][а-яёa-z-]+$/)
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
		@git != nil
	end		
	#Валидация с помощью предиката any? на наличие хотя бы одного контакта
	def contacts_null?
		[@phone, @telegram, @email].any? { |contact| contact != nil  }
	end	
	#Метод для двух валидаций - наличия контакта и гита\
	def validate_git_or_contact
		if git_null?
			puts "Гит не указан"
		else 
			puts "Гит студента: #{@git}"
		end

		unless contacts_null?
			puts "Ни один контакт студента не указан"
		else 
			puts "У студента есть хотя бы один контакт:"
			puts "-Номер телефона: #{@phone}"
			puts "-Телеграм: #{@telegram}"
			puts "-Почта: #{@email}"
		end
	end

	#Метод класса для отображения текущего состояния объекта
	def show_object_information
		puts "ID: #{@id}"
		puts "Фамилия: #{@last_name}"
		puts "Имя: #{@first_name}"
		puts "Отчество: #{@middle_name}"
		puts "Номер телефона: #{@phone}"
		puts "Телеграм: #{@telegram}"
		puts "Почта: #{@email}"
		puts "GitHub: #{@git}"
	end
end