require_relative 'student'
require_relative 'student_short'
require_relative 'student_list'
require_relative "../patterns_classes/data_list_student_short"
require 'yaml'
require_relative 'strategy_list_file'

class StudentsListYAML < StrategyListFile
  def read_from_file(filepath)
    yaml_data = YAML.load_file(filepath, permitted_classes: [Date, Symbol])
    yaml_data.map do |yaml_student|
      yaml_student[:birthdate] = yaml_student[:birthdate].to_s if yaml_student[:birthdate].is_a?(Date)
      Student.new(**yaml_student)
    end
  end

  def write_to_file(filepath, student_array)
    student_array_hash = student_array.map do |student|
      student.instance_variables
             .reject { |var| var == :@contact }
             .map { |var| [var.to_s.delete("@").to_sym, student.instance_variable_get(var)] }
             .to_h
    end

    File.open(filepath, 'w') do |file|
      file.write(YAML.dump(student_array_hash))
    end
  end
end