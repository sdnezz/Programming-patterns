#Подключаем класс студентов из отдельного файла
require_relative 'class_student'

#Создаем несколько объектов класса с разными комбинациями необязательных полей
student_example = Student.new(
	id: 1,
	last_name: "Петров",
	first_name: "Петя",
	middle_name: "Петрович", 
	phone: "12345678901",
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
	phone: "+880053535358889",
	telegram: "kislayavalya"
	)
#Вызываем метод вывода информации об объекте класса на экран
student_example.show_object_information
student_me.show_object_information
student_valya.show_object_information

student_example.set_contacts(phone: "89998887766", email: "new_email@example.com")
student_example.validate_git_or_contact
student_example.show_object_information

