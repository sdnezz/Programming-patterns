#Подключаем класс студентов из отдельного файла
require_relative 'student'
require_relative 'person'
require_relative 'student_short'
require_relative 'binary_tree'
require_relative "../patterns_classes/data_list_student_short"
# Создаем несколько экземпляров класса с разными комбинациями необязательных полей
student_example = Student.new(
	id: 1,
	last_name: "Петров",
	first_name: "Петя",
	middle_name: "Петрович", 
	phone: 12345678901,
	telegram: "@exmpltg",
	git: "github.com/example",
	birthdate: "1998/07/23"
)
student_me = Student.new(
	id: 2,
	last_name: "Дука",
	first_name: "Виталий",
	middle_name: "Андреевич", 
	email: "twinknezz@gmail.com",
	git: "github.com/sdnezz",
	birthdate: "1995/06/15"
)
student_valya = Student.new(
	id: 3,
	last_name: "Кислый",
	first_name: "Валентин",
	middle_name: "Кирилыч", 
	phone: 88005353531,
	telegram: "@kislayavalya",
	birthdate: "1992/12/30"
)

# Вызываем метод вывода информации об объекте класса на экран
puts student_example
# Изменяем контакты, только обращаясь к методу объекта класса для них
student_example.set_contacts(phone: 89998887766, email: "new_email@example.com")
puts student_example
# Проверяем наличие гита и контактов
student_example.validate_git_and_contact

# Выводим гит, инициалы и контакты через отдельные методы объекта класса
puts student_example.short_name
puts student_example.short_info
puts student_example.contact_info

# Выводим краткую информацию через метод объекта класса
puts student_example.get_info

# Создаем объект класса с краткой информацией, передавая туда уже созданный объект другого класса
student_example_short = StudentShort.new_from_student(student_example)
student_me_short = StudentShort.new_from_student(student_me)
student_valya_short = StudentShort.new_from_student(student_valya)
student_example_short_2 = StudentShort.new_from_string(id: 2, str: "Иванов И.И.; github.com/ivan; ivan@example.com")
puts student_example_short_2
puts 
puts
students = [student_example, student_me, student_valya]
# Создаем бинарное сортированное дерево
tree = BinarySortedTree.new(students)

# Итерация по дереву
puts tree

students_short = [student_example_short, student_me_short, student_valya_short]

# Создаём объект DataListStudentShort
data_list_student_short = DataListStudentShort.new(students_short)

# Вызываем метод get_data и выводим результат
puts "Данные таблицы студентов:"
puts data_list_student_short.get_data