require_relative 'data_list'

class DataListStudentShort < DataList
  def initialize(students)
    super(students) # Передаём массив объектов в родительский конструктор
  end

  private def get_names
    [:@last_name_initials, :@git, :@contact]
  end
end

