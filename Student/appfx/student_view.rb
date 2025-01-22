require 'fox16'
include Fox

class StudentView < FXHorizontalFrame
  attr_accessor :selected_row, :current_page, :max_page, :data, :table, :selected_rows

  def initialize(parent, width:, height:)
    super(parent, width: width, height: height, opts: FRAME_THICK | LAYOUT_FILL)

    self.data = generate_demo_data
    self.current_page = 1
    self.max_page = (data.size / 20.0).ceil

    setup_filter_area
    setup_table_area
    setup_handle_area
  end

  # Настройка области фильтров
  def setup_filter_area
    filter_width = (self.width * 0.2).to_i
    @filter_area = FXVerticalFrame.new(self, width: filter_width, height: self.height, opts: FRAME_SUNKEN)

    add_name_field
    add_filter_part("Git")
    add_filter_part("Электронная почта")
    add_filter_part("Телефон")
    add_filter_part("Telegram")
  end

  # Настройка таблицы и кнопок пагинации
  def setup_table_area
    table_width = (self.width * 0.6).to_i
    @table_area = FXVerticalFrame.new(self, width: table_width, height: self.height, opts: FRAME_SUNKEN | LAYOUT_FILL)

    setup_table
    setup_page_buttons
  end

  # Настройка управления
  def setup_handle_area
    handle_width = (self.width * 0.085).to_i
    @handle_area = FXVerticalFrame.new(self, width: handle_width, height: self.height, opts: FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH)

    FXLabel.new(@handle_area, "Управление")
    @add_button = FXButton.new(@handle_area, 'Добавить', opts: FRAME_RAISED | LAYOUT_FILL_X)
    @update_button = FXButton.new(@handle_area, 'Обновить', opts: FRAME_RAISED | LAYOUT_FILL_X)
    @edit_button = FXButton.new(@handle_area, 'Изменить', opts: FRAME_RAISED | LAYOUT_FILL_X)
    @delete_button = FXButton.new(@handle_area, 'Удалить', opts: FRAME_RAISED | LAYOUT_FILL_X)

    @edit_button.disable
    @delete_button.disable
  end

  # Настройка таблицы
  def setup_table
    self.table = FXTable.new(@table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.rowHeaderWidth = 40
    setup_column_headers

    self.selected_rows = []
    self.table.connect(SEL_SELECTED) do
      self.selected_rows = (0...self.table.numRows).select { |i| self.table.rowSelected?(i) }

      case self.selected_rows.size
      when 0
        @edit_button.disable
        @delete_button.disable
      when 1
        @edit_button.enable
        @delete_button.enable
      else
        @edit_button.disable
        @delete_button.enable
      end
    end

    fill_table(current_page)
  end

  def setup_column_headers
    column_headers = [
      { name: "№", width: 30 },
      { name: "Фамилия и инициалы", width: 200 },
      { name: "Дата рождения", width: 150 },
      { name: "Git", width: 200 },
      { name: "Контакты", width: 250 }
    ]

    self.table.setTableSize(20, column_headers.size)
    column_headers.each_with_index do |col, index|
      self.table.setColumnText(index, col[:name])
      self.table.setColumnWidth(index, col[:width])
    end
  end

  def fill_table(page)
    start_row = (page - 1) * 20
    end_row = start_row + 20
    paged_data = self.data[start_row...end_row] || []

    (0...20).each do |row|
      (0...5).each { |col| self.table.setItemText(row, col, "") }
    end

    paged_data.each_with_index do |row_data, row_index|
      row_data.each_with_index do |item, col_index|
        self.table.setItemText(row_index, col_index, item || "")
      end
    end
  end

  def setup_page_buttons
    paging_frame = FXHorizontalFrame.new(@table_area, opts: LAYOUT_FILL_X)

    @prev_button = FXButton.new(paging_frame, "Предыдущая", opts: FRAME_RAISED)
    @page_info_label = FXLabel.new(paging_frame, "Страница #{current_page} из #{max_page}", opts: LAYOUT_CENTER_X)
    @next_button = FXButton.new(paging_frame, "Следующая", opts: FRAME_RAISED)

    @prev_button.connect(SEL_COMMAND) do
      if current_page > 1
        self.current_page -= 1
        fill_table(current_page)
        update_page_info
      end
    end

    @next_button.connect(SEL_COMMAND) do
      if current_page < max_page
        self.current_page += 1
        fill_table(current_page)
        update_page_info
      end
    end
  end

  def update_page_info
    @page_info_label.text = "Страница #{current_page} из #{max_page}"
  end

  # Фильтры
  def add_name_field
    part_frame = FXVerticalFrame.new(@filter_area, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    FXLabel.new(part_frame, "Фамилия и инициалы", opts: LAYOUT_LEFT)
    FXTextField.new(part_frame, 28, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
  end

  def add_filter_part(label_text)
    part_frame = FXVerticalFrame.new(@filter_area, opts: LAYOUT_FILL_X)
    FXLabel.new(part_frame, label_text, opts: LAYOUT_LEFT)

    combo_box, text_field = create_combo_with_text(part_frame)
    combo_box.connect(SEL_COMMAND) do
      text_field.enabled = combo_box.currentItem == 1
    end
  end

  def create_combo_with_text(part_frame)
    horizontal_frame = FXHorizontalFrame.new(part_frame, opts: LAYOUT_FILL_X)
    combo_box = FXComboBox.new(horizontal_frame, 10, opts: COMBOBOX_NORMAL | FRAME_SUNKEN | FRAME_THICK)
    combo_box.appendItem("Не важно")
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.numVisible = 3
    combo_box.setCurrentItem(0)

    text_field = FXTextField.new(part_frame, 15, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    text_field.enabled = false

    [combo_box, text_field]
  end

  def generate_demo_data
    Array.new(50) do |i|
      [
        (i + 1).to_s,
        "Фамилия #{i + 1} И.О.",
        "199#{rand(0..9)}-#{rand(1..12).to_s.rjust(2, '0')}-#{rand(1..28).to_s.rjust(2, '0')}",
        "https://github.com/user#{i + 1}",
        "+7-900-#{rand(100_0000..999_9999)}"
      ]
    end
  end
end
