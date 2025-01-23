require 'fox16'
include Fox

class StudentView < FXHorizontalFrame
  attr_accessor :selected_row, :current_page, :max_page, :data, :table, :selected_rows, :controller
  private :controller=
  def initialize(parent, width:, height:)
    super(parent, width: width, height: height, opts: FRAME_THICK | LAYOUT_FILL)
    self.current_page = 1
    self.controller = nil

    setup_filter_area
    setup_table_area
    setup_handle_area
  end

  def set_controller(controller)
    self.controller = controller
  end

  # Настройка области фильтров
  def setup_filter_area
    filter_width = (self.width * 0.2).to_i
    @filter_area = FXVerticalFrame.new(self, width: filter_width, height: self.height, opts: FRAME_SUNKEN)

    add_name_field
    @filters = {}
    @filters[:git] = add_filter_part("Git")
    @filters[:email] = add_filter_part("Электронная почта")
    @filters[:phone] = add_filter_part("Телефон")
    @filters[:telegram] = add_filter_part("Telegram")

    # Кнопка применить
    apply_button = FXButton.new(@filter_area, "Применить", opts: FRAME_RAISED | LAYOUT_FILL_X)
    apply_button.connect(SEL_COMMAND) do
      apply_filters
    end
  end

  def apply_filters
    filter_conditions = {
      git: @filters[:git][:combo_box].currentItem,
      email: @filters[:email][:combo_box].currentItem,
      phone: @filters[:phone][:combo_box].currentItem,
      telegram: @filters[:telegram][:combo_box].currentItem,
    }
    filter_texts = {
      git: @filters[:git][:text_field].text,
      email: @filters[:email][:text_field].text,
      phone: @filters[:phone][:text_field].text,
      telegram: @filters[:telegram][:text_field].text,
    }

    controller.filter_students(filter_conditions, filter_texts)
  end

  def setup_table_area
    table_width = (self.width * 0.6).to_i
    @table_area = FXVerticalFrame.new(self, width: table_width, height: self.height, opts: FRAME_SUNKEN | LAYOUT_FILL)
    setup_table
    setup_page_buttons
  end

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

    # Подключение текстового поля фильтра
    @filters.each_value do |filter|
      filter[:text_field].connect(SEL_CHANGED) do |_, _, _|
        apply_filters
      end
    end
    # Подключение кнопок к методам контроллера
    @add_button.connect(SEL_COMMAND) do
      # Открываем форму для ввода данных
      new_student = open_add_student_form
      controller.add_student(new_student) if new_student # Передаём созданного студента
    end
    @update_button.connect(SEL_COMMAND) do
      controller.refresh_data
    end
    @edit_button.connect(SEL_COMMAND) do
      if selected_rows.size == 1
        row_index = selected_rows.first
        student_id = @view.table.getItemText(row_index, 0).to_i
        student = @student_list.db.get_student_by_id(student_id)

        updated_student = open_edit_student_form(student)
        update_student(student_id, updated_student) if updated_student
      end
    end
    @delete_button.connect(SEL_COMMAND) { controller.delete_selected_students }
  end

  def open_add_student_form
    dialog = FXDialogBox.new(self, "Добавить студента", opts: DECOR_TITLE | DECOR_BORDER)
    content = FXVerticalFrame.new(dialog, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Поля ввода
    FXLabel.new(content, "Имя:")
    first_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)

    FXLabel.new(content, "Фамилия:")
    last_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)

    FXLabel.new(content, "Отчество:")
    middle_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)

    FXLabel.new(content, "Дата рождения:")
    birthdate_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)

    FXLabel.new(content, "Телефон:")
    phone_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)

    # Кнопки
    buttons = FXHorizontalFrame.new(content, opts: LAYOUT_FILL_X)
    add_button = FXButton.new(buttons, "Добавить", opts: FRAME_RAISED)
    cancel_button = FXButton.new(buttons, "Отмена", opts: FRAME_RAISED)

    result = nil
    add_button.connect(SEL_COMMAND) do
      result = Student.new(
        first_name: first_name_field.text,
        last_name: last_name_field.text,
        middle_name: middle_name_field.text,
        birthdate: birthdate_field.text,
        phone: phone_field.text
      )
      dialog.accept
    end

    cancel_button.connect(SEL_COMMAND) { dialog.reject }

    dialog.execute
    result
  end


  def open_edit_student_form(student)
    dialog = FXDialogBox.new(self, "Изменить данные студента", opts: DECOR_TITLE | DECOR_BORDER)
    content = FXVerticalFrame.new(dialog, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)

    FXLabel.new(content, "Имя:")
    first_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    first_name_field.text = student.first_name

    FXLabel.new(content, "Фамилия:")
    last_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    last_name_field.text = student.last_name

    FXLabel.new(content, "Отчество:")
    middle_name_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    middle_name_field.text = student.middle_name

    FXLabel.new(content, "Git:")
    git_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    git_field.text = student.git

    FXLabel.new(content, "Телефон:")
    phone_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    phone_field.text = student.phone

    FXLabel.new(content, "Email:")
    email_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    email_field.text = student.email

    FXLabel.new(content, "Telegram:")
    telegram_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    telegram_field.text = student.telegram

    FXLabel.new(content, "Дата рождения (YYYY-MM-DD):")
    birthdate_field = FXTextField.new(content, 30, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    birthdate_field.text = student.birthdate

    buttons = FXHorizontalFrame.new(content, opts: LAYOUT_FILL_X)
    save_button = FXButton.new(buttons, "Сохранить", opts: FRAME_RAISED)
    cancel_button = FXButton.new(buttons, "Отмена", opts: FRAME_RAISED)

    result = nil
    save_button.connect(SEL_COMMAND) do
      result = Student.new(
        first_name: first_name_field.text,
        last_name: last_name_field.text,
        middle_name: middle_name_field.text,
        git: git_field.text,
        phone: phone_field.text,
        email: email_field.text,
        telegram: telegram_field.text,
        birthdate: birthdate_field.text
      )
      dialog.close
    end
    cancel_button.connect(SEL_COMMAND) { dialog.close }

    dialog.execute
    result
  end

  # Настройка таблицы
  def setup_table
    self.table = FXTable.new(@table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.rowHeaderWidth = 40
    self.table.setTableSize(20, 5) # Устанавливаем 20 строк и 5 столбцов по умолчанию
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
  end

  def setup_column_headers
    column_headers = [
      { name: "№", width: 50 },
      { name: "Фамилия и инициалы", width: 200 },
      { name: "Git", width: 200 },
      { name: "Контакты", width: 250 }
    ]

    self.table.setTableSize(20, column_headers.size)
    column_headers.each_with_index do |col, index|
      self.table.setColumnText(index, col[:name])
      self.table.setColumnWidth(index, col[:width])
    end

    # Добавляем обработчик сортировки по столбцу "Фамилия и инициалы"
    self.table.connect(SEL_COMMAND) do |_, _, event|
      if event.column == 1 # Номер столбца "Фамилия и инициалы"
        @sort_order ||= :asc
        @sort_order = @sort_order == :asc ? :desc : :asc
        controller.sort_by_column(:last_name, @sort_order)
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
        controller.refresh_data(current_page) # Используем refresh_data из контроллера
        update_page_info
      end
    end

    @next_button.connect(SEL_COMMAND) do
      if current_page < max_page
        self.current_page += 1
        controller.refresh_data(current_page) # Используем refresh_data из контроллера
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

    { combo_box: combo_box, text_field: text_field }
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
end
