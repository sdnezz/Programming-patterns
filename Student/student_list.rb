require_relative 'student'
require_relative 'student_short'
require_relative "../patterns_classes/data_list_student_short"

class StudentList
  attr_accessor :filepath, :strategy, :db
  attr_reader :student_array

  def initialize(filepath: nil, strategy: nil, db: nil, student_array: nil)
    if db
      @db = db
      @student_array = []
    elsif filepath && strategy
      @filepath = filepath
      @strategy = strategy
      @student_array = student_array || []
    else
      raise ArgumentError, 'Необходимо указать либо базу данных (db), либо filepath и strategy'
    end
  end

  # Добавьте методы для работы с @db, если используется база данных
  def get_student_by_id(id)
    db ? db.get_student_by_id(id) : student_array.find { |student| student.id == id }
  end

  def get_k_n_student_short_list(page:, amount_rows: 20)
    total_students = db ? db.get_student_count : student_array.size
    puts "Всего студентов: #{total_students}" # Отладка

    raise ArgumentError, 'Недопустимый номер страницы' if page <= 0 || (page - 1) * amount_rows >= total_students
    raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

    if db
      db.get_k_n_student_short_list(page: page, amount_rows: amount_rows)
    else
      start_index = (page - 1) * amount_rows
      end_index = [start_index + amount_rows - 1, student_array.size - 1].min
      student_short_array = student_array[start_index..end_index].map { |student| StudentShort.new_from_student(student) }
      DataListStudentShort.new(student_short_array)
    end
  end

  def student_array=(student_array)
    if student_array.is_a?(Array) || student_array.nil?
      @student_array = student_array
    else
      raise TypeError, 'Ожидается массив объектов Student или nil'
    end
  end

  private :filepath=, :student_array=

  # Чтение данных с уникальностью и перенумерацией
  def read_from_file
    raw_data = strategy.read_from_file(filepath) # Считываем данные
    unique_data = raw_data.uniq # Удаляем дубликаты
    self.student_array = renumber_students(unique_data) # Перенумерация
  end

  # Метод для перенумерации студентов
  def renumber_students(students)
    students.each_with_index do |student, index|
      student.id = index + 1
    end
    students
  end

  def write_to_file
    self.strategy.write_to_file(filepath, student_array)
  end

  # Общие методы
  # def get_student_by_id(required_id)
  #   self.student_array.find { |student| student.id == required_id }
  # end

  # def get_k_n_student_short_list(page:, amount_rows: 20)
  #   raise ArgumentError, 'Недопустимый номер страницы' if page <= 0
  #   raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

  #   student_short_array = self.student_array.map { |student| StudentShort.new_from_student(student) }

  #   start_index = (page - 1) * amount_rows
  #   end_index = [start_index + amount_rows - 1, student_short_array.size - 1].min

  #   DataListStudentShort.new(student_short_array[start_index..end_index])
  # end

  def add_student(student)
    if self.student_array.any? { |existing_student| existing_student == student }
      raise ArgumentError, "Студент с такими данными уже существует: #{student}"
    end

    max_id = self.student_array.map(&:id).compact.max || 0
    student.id = max_id + 1
    self.student_array << student
  end

  # Замена студента с проверкой на уникальность
  def replace_student_by_id(required_id, new_student)
    if self.student_array.any? { |existing_student| existing_student == new_student }
      raise ArgumentError, "Студент с такими данными уже существует: #{new_student}"
    end

    index = self.student_array.find_index { |student| student.id == required_id }
    self.student_array[index] = new_student if index
  end

  def delete_student_by_id(required_id)
    self.student_array.delete_if { |student| student.id == required_id }
  end

  def get_student_short_count
    if db
      db.get_student_count # Этот метод должен возвращать количество записей в БД
    else
      self.student_array.size
    end
  end
end
