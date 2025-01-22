require 'fox16'
include Fox

class HandlerFrame < FXVerticalFrame
  def initialize(parent, width:, height:, opts: FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH)
    super(parent, opts: opts, width: width, height: height)
    setup_handler
  end

  def setup_handler
    FXLabel.new(self, "Управление")

    # Кнопки управления
    FXButton.new(self, 'Добавить студента', opts: FRAME_RAISED | LAYOUT_FILL_X)
    FXButton.new(self, 'Обновить студента', opts: FRAME_RAISED | LAYOUT_FILL_X)
    FXButton.new(self, 'Удалить студента', opts: FRAME_RAISED | LAYOUT_FILL_X)
  end
end
