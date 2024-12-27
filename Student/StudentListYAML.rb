require_relative 'student'
require_relative 'student_short'
require_relative "../patterns_classes/data_list_student_short"
require 'yaml'

class StudentsListYAML
  attr_accessor :filepath
  attr_reader :student_array

  def initialize(filepath:, student_array: nil)
    self.filepath = filepath
    self.student_array = student_array || []
  end

  def student_array=(student_array)
    if student_array.is_a?(Array) || student_array.nil?
      @student_array = student_array
    else
      raise TypeError, 'Ожидается массив объектов Student или nil'
    end
  end

  private :filepath=, :student_array=

  def read_from_file
    yaml_data = YAML.load_file(self.filepath, permitted_classes: [Date, Time, Symbol])
    student_array_hash = yaml_data.map do |yaml_student|
      # Преобразуем ключи в строки
      yaml_student[:birthdate] = yaml_student[:birthdate].to_s if yaml_student[:birthdate].is_a?(Date)
      # Создаём объект Student
      Student.new(**yaml_student)
    end
    self.student_array = student_array_hash
  end

  # Запись данных в YAML-файл
  def write_to_file(student_array = self.student_array)
    student_array_hash = student_array.map do |student|
      student.instance_variables
             .reject { |var| var == :@contact } # Исключаем @contact
             .map { |var| [var.to_s.delete("@").to_sym, student.instance_variable_get(var)] }
             .to_h
    end

    File.open(self.filepath, 'w') do |file|
      file.write(YAML.dump(student_array_hash))
    end
  end


  # Получение объекта Student по ID
  def get_student_by_id(required_id)
    self.student_array.find { |student| student.id == required_id }
  end

  # Получение списка объектов StudentShort
  def get_k_n_student_short_list(page:, amount_rows: 20)
    raise ArgumentError, 'Недопустимый номер страницы' if page <= 0
    raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

    student_short_array = self.student_array.map { |student| StudentShort.new_from_student(student) }

    start_index = (page - 1) * amount_rows
    end_index = [start_index + amount_rows - 1, student_short_array.size - 1].min

    DataListStudentShort.new(student_short_array[start_index..end_index])
  end

  # Сортировка студентов по фамилии
  def sort_by_name
    self.student_array.sort_by! { |student| student.last_name }
  end

  # Добавление нового студента (с автоформированием ID)
  def add_student(student)
    max_id = self.student_array.map(&:id).compact.max || 0
    student.id = max_id + 1
    self.student_array << student
  end

  # Замена студента по ID
  def replace_student_by_id(required_id, new_student)
    index = self.student_array.find_index { |student| student.id == required_id }
    self.student_array[index] = new_student if index
  end

  # Удаление студента по ID
  def delete_student_by_id(required_id)
    self.student_array.delete_if { |student| student.id == required_id }
  end

  # Получение количества студентов
  def get_student_short_count
    self.student_array.size
  end
end