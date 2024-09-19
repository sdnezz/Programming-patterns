#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Student
	#Конструктор с хэшем параметров
  	def initialize(params = {})
	    #fetch для обязательных полей
	    @id = params.fetch(:id)
	    @last_name = params.fetch(:last_name)
	    @first_name = params.fetch(:first_name)
	    @middle_name = params.fetch(:middle_name)
	    @phone = params[:phone] || "Не указан"
	    @telegram = params[:telegram] || "Не указан"
	    @email = params[:email] || "Не указана"
	    @git = params[:git] || "Не указан"
  	end

	#Автоматическое создание геттера и сеттера для каждого поля с помощью атрибута
	attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :git

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