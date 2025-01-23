require_relative 'student_view'
require_relative 'student_list_controller'
require_relative '../student_list'
require_relative '../database/students_list_DB'
require 'fox16'
include Fox

class MainWindow < FXMainWindow
  def initialize(app)
    super(app, "Students", width: 1220, height: 750)

    # Создаем вкладки
    tab_placement = FXTabBook.new(self, opts: LAYOUT_FILL)

    tab_student_list_view = FXTabItem.new(tab_placement, 'Student List View')
    setup_student_list_view(tab_placement)

    tab_2 = FXTabItem.new(tab_placement, 'Tab2')
    FXVerticalFrame.new(tab_placement, opts: FRAME_THICK | LAYOUT_FILL)

    tab_3 = FXTabItem.new(tab_placement, 'Tab3')
    FXVerticalFrame.new(tab_placement, opts: FRAME_THICK | LAYOUT_FILL)
  end

  def setup_student_list_view(concrete_tab)
    # Подключение к PostgreSQL
    student_list_db = StudentsListDB.new(
      host: 'localhost',
      username: 'postgres',
      password: '123', # Укажите ваш пароль
      database: 'student_db'
    )
    
    # Создание объектов модели, представления и контроллера
    student_list = StudentList.new(db: student_list_db)
    student_list_view = StudentView.new(concrete_tab, width: 1300, height: 750)
    student_list_controller = StudentListController.new(student_list, student_list_view)

    # Установка связи между представлением и контроллером
    student_list_view.set_controller(student_list_controller)

    # Загрузка данных в таблицу
    student_list_controller.refresh_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    MainWindow.new(app)
    app.create
    app.run
  end
end