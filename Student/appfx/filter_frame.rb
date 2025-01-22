class FilterFrame < FXVerticalFrame
  def initialize(parent, width:, height:, opts: FRAME_SUNKEN | LAYOUT_FILL_X)
    super(parent, opts: opts, width: width, height: height)

    add_name_field
    add_filter_part("Git")
    add_filter_part("Электронная почта")
    add_filter_part("Телефон")
    add_filter_part("Telegram")
  end

  def add_name_field
    part_frame = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    FXLabel.new(part_frame, "Фамилия и инициалы", opts: LAYOUT_LEFT)
    FXTextField.new(part_frame, 28, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X) # Уменьшаем ширину
  end

  def add_filter_part(label_text)
    part_frame = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    FXLabel.new(part_frame, label_text, opts: LAYOUT_LEFT)

    create_combo_with_text(part_frame)
  end

  def create_combo_with_text(part_frame)
    horizontal_frame = FXHorizontalFrame.new(part_frame, opts: LAYOUT_FILL_X)

    combo_box = FXComboBox.new(horizontal_frame, 8, opts: COMBOBOX_NORMAL | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_X) # Уменьшаем ширину
    combo_box.appendItem("Не важно")
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.numVisible = 3
    combo_box.setCurrentItem(0)

    text_field = FXTextField.new(horizontal_frame, 15, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X) # Уменьшаем ширину
    text_field.enabled = false # По умолчанию отключено

    combo_box.connect(SEL_COMMAND) do
      case combo_box.currentItem
      when 1
        text_field.enabled = true
      else
        text_field.enabled = false
      end
    end
  end
end