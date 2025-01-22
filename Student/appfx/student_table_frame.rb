require 'fox16'
include Fox

class StudentTableFrame < FXHorizontalFrame
  def initialize(parent, width:, height:, opts: FRAME_SUNKEN | LAYOUT_FILL)
    super(parent, opts: opts, width: width, height: height)

    main_frame = FXVerticalFrame.new(self, opts: LAYOUT_FILL)

    # Создаем таблицу
    @table = FXTable.new(main_frame, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    setup_table

    # Заполняем таблицу данными
    @data = generate_demo_data
    fill_table(0)

    # Настраиваем кнопки пагинации
    setup_paging_controls(main_frame)
  end

  # Настройка структуры таблицы
  def setup_table
    @table.setTableSize(20, 5) # По умолчанию показываем 20 строк, 5 колонок
    @table.setRowHeaderWidth(30)

    # Устанавливаем заголовки
    columns = ["№", "Фамилия и Инициалы", "Дата рождения", "Git", "Контакт"]
    columns.each_with_index do |column_name, index|
      @table.setColumnText(index, column_name)
      @table.setColumnWidth(index, 160)
    end

    # Подключаем обработчик для заголовков
    @table.connect(SEL_COMMAND) do |_, _, pos|
      if pos.row == -1 && pos.col == 1 # Если нажали на заголовок столбца "Фамилия и Инициалы"
        sort_column(1) # Сортируем по столбцу "Фамилия и Инициалы"
      end
    end
  end

  # Генерация демонстрационных данных
  def generate_demo_data
    Array.new(50) do |i|
      [
        "Фамилия #{i + 1} И.О.",
        "199#{rand(0..9)}-#{rand(1..12).to_s.rjust(2, '0')}-#{rand(1..28).to_s.rjust(2, '0')}",
        "https://github.com/user#{i + 1}",
        "+7-900-#{rand(100_0000..999_9999)}"
      ]
    end
  end

  # Заполнение таблицы данными
  def fill_table(page)
    start_row = page * 20
    demo_data = @data

    # Очищаем таблицу
    (0...20).each do |row|
      (0...5).each do |col|
        @table.setItemText(row, col, "")
      end
    end

    # Заполняем данными
    (start_row...(start_row + 20)).each_with_index do |index, row|
      break if index >= demo_data.size
      data = demo_data[index]
      @table.setItemText(row, 0, (index + 1).to_s)
      @table.setItemText(row, 1, data[0])
      @table.setItemText(row, 2, data[1])
      @table.setItemText(row, 3, data[2])
      @table.setItemText(row, 4, data[3])
    end

    @max_page = (demo_data.size / 20.0).ceil
  end

  # Настройка кнопок пагинации
  def setup_paging_controls(main_frame)
    paging_frame = FXHorizontalFrame.new(main_frame, opts: LAYOUT_FILL_X | LAYOUT_LEFT)

    @prev_button = FXButton.new(paging_frame, "Предыдущая", opts: FRAME_RAISED)
    @page_info_label = FXLabel.new(paging_frame, "", opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y)
    @current_page = 0
    update_page_info
    @next_button = FXButton.new(paging_frame, "Следующая", opts: FRAME_RAISED)

    # Обработка кнопок
    @prev_button.connect(SEL_COMMAND) do
      if @current_page > 0
        @current_page -= 1
        fill_table(@current_page)
        update_page_info
      end
    end

    @next_button.connect(SEL_COMMAND) do
      if @current_page < @max_page - 1
        @current_page += 1
        fill_table(@current_page)
        update_page_info
      end
    end
  end

  # Обновление информации о текущей странице
  def update_page_info
    @page_info_label.text = "Страница #{@current_page + 1} из #{@max_page}"
  end

  # Сортировка данных по колонке "Фамилия и Инициалы"
  def sort_column(column_index)
    @data.sort_by! { |row| row[column_index] }
    fill_table(@current_page)
  end
end