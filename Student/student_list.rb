require_relative 'student'
require_relative 'student_short'
require_relative "../patterns_classes/data_list_student_short"

class StudentList
  attr_accessor :filepath, :strategy
  attr_reader :student_array

  def initialize(filepath:, strategy:, student_array: nil)
    self.filepath = filepath
    self.strategy = strategy
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

  # Абстрактные методы
  def read_from_file
    self.student_array = strategy.read_from_file(filepath)
  end

  def write_to_file
    self.strategy.write_to_file(filepath, student_array)
  end

  # Общие методы
  def get_student_by_id(required_id)
    self.student_array.find { |student| student.id == required_id }
  end

  def get_k_n_student_short_list(page:, amount_rows: 20)
    raise ArgumentError, 'Недопустимый номер страницы' if page <= 0
    raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

    student_short_array = self.student_array.map { |student| StudentShort.new_from_student(student) }

    start_index = (page - 1) * amount_rows
    end_index = [start_index + amount_rows - 1, student_short_array.size - 1].min

    DataListStudentShort.new(student_short_array[start_index..end_index])
  end

  def sort_by_name
    self.student_array.sort_by! { |student| student.last_name }
  end

  def add_student(student)
    max_id = self.student_array.map(&:id).compact.max || 0
    student.id = max_id + 1
    self.student_array << student
  end

  def replace_student_by_id(required_id, new_student)
    index = self.student_array.find_index { |student| student.id == required_id }
    self.student_array[index] = new_student if index
  end

  def delete_student_by_id(required_id)
    self.student_array.delete_if { |student| student.id == required_id }
  end

  def get_student_short_count
    self.student_array.size
  end
end
