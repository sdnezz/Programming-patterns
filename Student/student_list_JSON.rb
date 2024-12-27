require_relative 'student'
require_relative 'student_short'
require_relative 'student_list'
require_relative "../patterns_classes/data_list_student_short"
require 'json'

class StudentsListJSON < StudentList
  def read_from_file
    json_data = JSON.parse(File.read(self.filepath), symbolize_names: true)
    student_array_hash = json_data.map { |json_student| Student.new(**json_student) }
    self.student_array = student_array_hash
  end

  def write_to_file(student_array = self.student_array)
    student_array_hash = student_array.map do |student|
      student.instance_variables
             .reject { |var| var == :@contact }
             .map { |var| [var.to_s.delete("@").to_sym, student.instance_variable_get(var)] }
             .to_h
    end

    File.open(self.filepath, 'w') do |file|
      file.write(JSON.pretty_generate(student_array_hash))
    end
  end
end