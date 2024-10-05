#Подключаем класс студентов из отдельного файла
require_relative 'class_student'
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
puts student_example
#Изменяем контакты, только обращаясь к методу объекта класса для них
student_example.set_contacts(phone: 89998887766, email: "new_email@example.com")
#Проверяем наличие гита и контактов
student_example.validate_git_or_contact

#Выводим гит,инициалы и контакты через отдельные методы объекта класса
puts student_example.git_info

puts student_example.short_name

puts student_example.contacts_info

#Выводим краткую информацию через метод объекта класса
puts student_example.get_info

#Создаем наследник-объект класса с краткой информацией через обращение к суперклассу
student_example_short = student_example.short_info
puts student_example_short