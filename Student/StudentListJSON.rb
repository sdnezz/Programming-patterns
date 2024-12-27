require_relative 'student'
require_relative 'student_short'
require_relative "../patterns_classes/data_list_student_short"
require 'json'

class StudentsListJSON
  attr_accessor :filepath
  attr_reader :student_array

  def initialize(filepath:, student_array: nil)
    self.filepath = filepath
    self.student_array = student_array
  end

  private def student_array=(student_array)
    if student_array.nil? || student_array.is_a?(Array)
      @student_array = student_array
    else
      raise TypeError, 'Неверный тип входных данных'
    end
  end

  private :filepath=

  # Чтение данных из файла
  def read_from_file
    json_data = JSON.parse(File.read(self.filepath), { symbolize_names: true })
    student_array_hash = json_data.map { |json_student| Student.new(**json_student) }
    self.student_array = student_array_hash
  end

  # Запись данных в файл
  def write_to_file(student_array = self.student_array, writing_mode = 'w')
    student_array_hash = student_array.map do |student|
      student.instance_variables.map do |var|
        [var.to_s.delete("@").to_sym, student.instance_variable_get(var)]
      end.to_h
    end

    File.open(self.filepath, writing_mode) do |file|
      file.write(JSON.pretty_generate(student_array_hash))
    end
  end

  # Получение объекта Student по ID
  def get_student_by_id(required_id)
    self.student_array.find { |student| student.id == required_id }
  end

  # Получение списка объектов StudentShort (постранично)
  def get_k_n_student_short_list(page:, amount_rows: 20, data_list: nil)
    if page <= 0
      raise ArgumentError, 'Недопустимый номер страницы'
    elsif amount_rows <= 0
      raise ArgumentError, 'Недопустимое количество записей'
    end

    student_short_array = self.student_array.map { |student| StudentShort.new_from_student(student) }

    start_index = (page - 1) * amount_rows
    end_index = [start_index + amount_rows - 1, student_short_array.size - 1].min

    DataListStudentShort.new(student_short_array[start_index..end_index])
  end

  # Сортировка по фамилии
  def sort_by_name
    self.student_array.sort_by { |student| student.last_name }
  end

  # Добавление нового студента
  def add_student(student)
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
