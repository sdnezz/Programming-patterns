require_relative 'frame_handler'
require_relative 'student_table_frame'

require 'fox16'
include Fox

class MainWindow < FXMainWindow
  def initialize(app)
    super(app, "Students", width: 1100, height: 750)

    # Создаем вкладки
    tab_placement = FXTabBook.new(self, opts: LAYOUT_FILL)

    # Вкладка 1: Student List View
    tab_student_list_view = FXTabItem.new(tab_placement, 'Student List View')
    tab_student_list_view_frame = FXHorizontalFrame.new(tab_placement, opts: FRAME_THICK | LAYOUT_FILL)
    setup_student_list_view_areas(tab_student_list_view_frame)

    # Вкладка 2
    tab_2 = FXTabItem.new(tab_placement, 'Tab2')
    tab_2_frame = FXVerticalFrame.new(tab_placement, opts: FRAME_THICK | LAYOUT_FILL)

    # Вкладка 3
    tab_3 = FXTabItem.new(tab_placement, 'Tab3')
    tab_3_frame = FXVerticalFrame.new(tab_placement, opts: FRAME_THICK | LAYOUT_FILL)
  end

  def setup_student_list_view_areas(parent)
    # Область фильтрации
    filter_area = FXHorizontalFrame.new(parent, opts: FRAME_SUNKEN | LAYOUT_FIX_WIDTH, width: 200)

    # Таблица студентов
    table_area = StudentTableFrame.new(parent, width: 750, height: self.height)

    # Область управления
    handler_area = HandlerFrame.new(parent, width: 150, height: self.height)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

# Запуск приложения
if __FILE__ == $0
  FXApp.new do |app|
    MainWindow.new(app)
    app.create
    app.run
  end
end