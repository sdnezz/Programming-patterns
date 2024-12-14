require_relative 'data_list'

class DataListStudentShort < DataList

  def initialize(students)
    super(students) # Передаём массив объектов в родительский конструктор
  end

  # Реализация метода get_names
  protected def get_names
    # Специфичные имена атрибутов для StudentShort
    [:@last_name_initials, :@git, :@contact]
  end

  # Реализация метода get_data
  def get_data
    # Вызов базового метода get_names для получения имён атрибутов
    column_names = get_names

    # Формируем строки для DataTable
    table_data = []

    self.sorted_array.each_with_index do |element, index|
      # Нулевой столбец — порядковый номер
      row = [index + 1]

      # Добавляем значения атрибутов (кроме @id)
      column_names.each do |name|
        row << element[:value].instance_variable_get(name)
      end

      table_data << row
    end

    # Создаём объект DataTable
    data_table = DataTable.new(table_data)

    # Возвращаем строковое представление таблицы
    data_table.to_s
  end
end