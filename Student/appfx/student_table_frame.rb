require 'fox16'
include Fox

class StudentTableFrame < FXHorizontalFrame
  def initialize(parent, width:, height:, opts: FRAME_SUNKEN | LAYOUT_FILL)
    super(parent, opts: opts, width: width, height: height)
    @table = FXTable.new(self, opts: LAYOUT_FILL)
    setup_table
  end

  def setup_table
    # Поля студента
    columns = [
      "ID", "Фамилия", "Имя", "Отчество", 
      "GitHub", "Телефон", "Telegram", 
      "Электронная почта", "Дата рождения"
    ]

    # Устанавливаем размер таблицы
    @table.setTableSize(20, columns.size)

    # Устанавливаем заголовки колонок
    columns.each_with_index do |column_name, index|
      @table.setColumnText(index, column_name)
    end

    # Устанавливаем данные (пример данных)
    @table.setItemText(0, 0, "1")
    @table.setItemText(0, 1, "Иванов")
    @table.setItemText(0, 2, "Иван")
    @table.setItemText(0, 3, "Иванович")
    @table.setItemText(0, 4, "github.com/ivan")
    @table.setItemText(0, 5, "+79123456789")
    @table.setItemText(0, 6, "@ivan")
    @table.setItemText(0, 7, "ivanov@example.com")
    @table.setItemText(0, 8, "1995-05-20")

    # Задаем размеры колонок
    columns.each_with_index do |_col, index|
      @table.setColumnWidth(index, 141)
    end
  end
end
