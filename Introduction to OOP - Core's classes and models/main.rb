#Подключаем класс студентов из отдельного файла
require_relative 'ClassStudent'

#Создаем несколько объектов класса
student_example = Student.new(1, 'Петров', 'Петя', 'Петрович', '1234567890', '@exmpltg', 'petr@example.com', 'github.com/example')
student_me = Student.new(2, 'Дука', 'Виталий', 'Андреевич', '89184786968', '@sdnezz', 'twinknezz@gmail.com', 'https://github.com/sdnezz')
student_valya = Student.new(3, 'Кислый', 'Валентин', 'Иосифович', '88005353535', '@kislyavalya', 'valya@example.com', 'github.com/kislyavaluxa')

#Вызываем метод вывода информации об объекте класса на экран
student_example.show_object_information
student_me.show_object_information
student_valya.show_object_information