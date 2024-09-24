#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Student
	#Конструктор с хэшем параметров
  	def initialize(params = {})
	    #fetch для обязательных полей (также сделали параметр id необязательным)
	    @id = params.fetch(:id) || "Не указан"
	    @last_name = params.fetch(:last_name)
	    @first_name = params.fetch(:first_name)
	    @middle_name = params.fetch(:middle_name)
	    #вызов метода проверки (валидации) на корректность телефона
	    @phone = if params[:phone] && Student.phone_valid?(params[:phone])
            params[:phone]
         else
            "Не указан"
         end
	    @telegram = params[:telegram] || "Не указан"
	    @email = params[:email] || "Не указана"
	    @git = params[:git] || "Не указан"
  	end

	#Автоматическое создание геттера и сеттера для каждого поля с помощью атрибута
	attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

	def self.phone_valid?(phone)
		#проверяем, длина строки равна 11 или 12 но с началом "+" и состоит ли из целочисленных значений
		if phone.length == 11
			#регулярное выражение с проверкой на наличие последовательности цифр \d+
			return phone.match?(/^\d+$/)
		elsif phone.length == 12
			#регулярное выражение с проверкой на наличие + и последовательности цифр \d+
			return phone.match?(/^\+\d+$/)
		else
			return false
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