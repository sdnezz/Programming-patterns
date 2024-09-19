#Соглашения о наименованиях: snake_case, CamelCase, getter, setter=
class Student
	#Конструктор класса без дублирования кода с необязательными полями
	def initialize(id:, last_name:, first_name:, middle_name:, phone:nil, telegram:nil, email:nil, git:nil)
		@id, @last_name, @first_name, @middle_name, @phone, @telegram, @email, @git = id, last_name, first_name, middle_name, phone, telegram, email, git
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