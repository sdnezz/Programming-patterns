#Подключаем класс студентов из отдельного файла
require_relative 'student'
require_relative 'person'
require_relative 'student_short'
require_relative 'binary_tree'
require_relative "../patterns_classes/data_list_student_short"
require_relative 'student_list_JSON'
require_relative 'student_list_YAML'
require_relative 'student_list'
require_relative 'strategy_list_file'
require_relative 'database/students_list_DB'

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

students_short = [student_example_short, student_me_short, student_valya_short]

# Создаём объект DataListStudentShort
data_list_student_short = DataListStudentShort.new(students_short)

# Вызываем метод get_data и выводим результат
puts "Данные таблицы студентов:"
puts data_list_student_short.get_data

data_list_student_short.sorted_array = [student_me_short,student_valya_short]
puts "Данные таблицы студентов:"
puts data_list_student_short.get_data

# Используем JSON
students_list_json = StudentList.new(filepath: 'students.json', strategy: StudentsListJSON.new)

# Читаем из JSON
students_list_json.read_from_file
puts "Список студентов c jsona:"
students_list_json.student_array.each { |student| puts student }

students_list_json.delete_student_by_id(3)
# Добавляем нового студента и записываем
new_student = Student.new(first_name: 'Иван', last_name: 'Иванов', middle_name: 'Иванович', git: 'github.com/ivan')
students_list_json.add_student(new_student)
students_list_json.write_to_file


puts "Первая страница объектов StudentShort:"
data_list = students_list_json.get_k_n_student_short_list(page: 1, amount_rows: 3)
puts data_list.get_data

# Используем YAML
students_list_yaml = StudentList.new(filepath: 'students.yaml', strategy: StudentsListYAML.new)

# Читаем из YAML
students_list_yaml.read_from_file
puts "Список студентов c YAML:"
students_list_yaml.student_array.each { |student| puts student }

#======================DATABASE==============================#
db = StudentsListDB.new(host: 'localhost', username: 'postgres', password: '123', database: 'student_db')

# Пример добавления студента
new_student = Student.new(
  first_name: "Боря", last_name: "Голиков", middle_name: "Вячеславович",
  git: "github.com/btagoshi", phone: "+79595959592", email: "bratgoshi@example.com", birthdate: "2002-01-01"
)
# db.add_student(new_student)

# Пример получения студента по ID
student = db.get_student_by_id(30)
puts "студент с id 30"
puts student.to_s if student

# Пример получения короткого списка
data_list = db.get_k_n_student_short_list(page: 2, amount_rows: 20)
puts "Студенты"
puts data_list.get_data

# Удаление студента
db.delete_student_by_id(2)