#Подключаем класс студентов из отдельного файла
require_relative 'class_student'
require_relative 'student_short'
#Создаем несколько объектов класса с разными комбинациями необязательных полей
student_example = Student.new(
	id: 1,
	last_name: "Петров",
	first_name: "Петя",
	middle_name: "Петрович", 
	phone: 12345678901,
	telegram: "@exmpltg",
	email: "petr@example.com",
	git: "github.com/example"
	)
student_me = Student.new(
	id: 2,
	last_name: "Дука",
	first_name: "Виталий",
	middle_name: "Андреевич", 
	email: "twinknezz@gmail.com",
	git: "github.com/sdnezz"
	)
student_valya = Student.new(
	id: 3,
	last_name: "Кислый",
	first_name: "Валентин",
	middle_name: "Кирилыч", 
	phone: 88005353531 ,
	telegram: "@kislayavalya"
	)
#Вызываем метод вывода информации об объекте класса на экран
student_example.show_object_information
puts
student_me.show_object_information
puts
student_valya.show_object_information
puts
student_example.set_contacts(phone: 89998887766, email: "new_email@example.com")
puts
student_example.validate_git_or_contact
puts
student_example.show_object_information
puts
puts student_example.git_info
puts
puts student_example.short_name
puts
puts student_example.contacts_info
puts
puts student_example.get_info

student_short_1 = Student_short.new(student_example)
puts
student_short_2 = Student_short.new(3, student_valya.get_info)
puts
student_short_1.object_information
puts
student_short_2.object_information