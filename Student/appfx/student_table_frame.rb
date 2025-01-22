require 'fox16'
include Fox

class StudentTableFrame < FXHorizontalFrame
  def initialize(parent, width:, height:, opts: FRAME_SUNKEN | LAYOUT_FILL)
    super(parent, opts: opts, width: width, height: height)
    @table = FXTable.new(self, opts: LAYOUT_FILL)
    setup_table
  end

  def setup_table
    # Устанавливаем размер таблицы
    @table.setTableSize(5, 3)

    # Задаем заголовки
    @table.setColumnText(0, "ID")
    @table.setColumnText(1, "Фамилия")
    @table.setColumnText(2, "Имя")

    # Задаем данные
    @table.setItemText(0, 0, "1")
    @table.setItemText(0, 1, "Иванов")
    @table.setItemText(0, 2, "Иван")
  end
end