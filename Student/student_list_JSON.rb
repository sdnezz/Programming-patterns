require_relative 'student'
require_relative 'student_short'
require_relative 'student_list'
require_relative "../patterns_classes/data_list_student_short"
require 'json'
require_relative 'strategy_list_file'

class StudentsListJSON < StrategyListFile
  def read_from_file(filepath)
    json_data = JSON.parse(File.read(filepath), symbolize_names: true)
    json_data.map { |json_student| Student.new(**json_student) }
  end

  def write_to_file(filepath, student_array)
    student_array_hash = student_array.map do |student|
      student.instance_variables
             .reject { |var| var == :@contact }
             .map { |var| [var.to_s.delete("@").to_sym, student.instance_variable_get(var)] }
             .to_h
    end

    File.open(filepath, 'w') do |file|
      file.write(JSON.pretty_generate(student_array_hash))
    end
  end
end