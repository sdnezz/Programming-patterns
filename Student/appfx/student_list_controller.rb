class StudentListController
  attr_accessor :view, :student_list

  def initialize(student_list, view)
    @student_list = student_list
    @view = view

    # При создании контроллера загружаем данные в таблицу
    refresh_data
  end

  # Метод для получения количества страниц
  def get_max_page_num
    rows_per_page = @view.table.numRows
    return 1 if rows_per_page.zero? # Если строк на странице нет, возвращаем 1 страницу
    (@student_list.get_student_short_count.to_f / rows_per_page).ceil
  end

  def refresh_data(page = 1)
    rows_per_page = @view.table.numRows
    rows_per_page = 20 if rows_per_page.zero? # Устанавливаем значение по умолчанию

    data_list = @student_list.get_k_n_student_short_list(page: page, amount_rows: rows_per_page)
    data_table = data_list.get_data

    row_count = data_table.count_rows
    column_count = data_table.count_columns

    @view.table.setTableSize(row_count, column_count)
    @view.setup_column_headers

    global_start_index = (page - 1) * rows_per_page

    (0...row_count).each do |row_index|
      @view.table.setItemText(row_index, 0, (global_start_index + row_index + 1).to_s) # Глобальная нумерация
      (1...column_count).each do |column_index|
        value = data_table.matrix[row_index][column_index]
        @view.table.setItemText(row_index, column_index, value.to_s)
      end
    end

    @view.current_page = page
    @view.max_page = get_max_page_num
    @view.update_page_info
  end

  def filter_students(filter_conditions, filter_texts)
    filtered_students = @student_list.db.get_filtered_students(filter_conditions, filter_texts)

    # Отобразим отфильтрованные данные
    data_list = DataListStudentShort.new(filtered_students.map { |s| StudentShort.new_from_student(s) })
    data_table = data_list.get_data

    row_count = data_table.count_rows
    column_count = data_table.count_columns

    @view.table.setTableSize(row_count, column_count)

    (0...row_count).each do |row_index|
      (0...column_count).each do |column_index|
        @view.table.setItemText(row_index, column_index, data_table.matrix[row_index][column_index].to_s)
      end
    end
  end

  def sort_by_column(column, order)
    sorted_students = @student_list.db.get_sorted_students(column, order)
    data_list = DataListStudentShort.new(sorted_students.map { |s| StudentShort.new_from_student(s) })
    data_table = data_list.get_data

    row_count = data_table.count_rows
    column_count = data_table.count_columns

    @view.table.setTableSize(row_count, column_count)

    (0...row_count).each do |row_index|
      @view.table.setItemText(row_index, 0, (row_index + 1).to_s) # Нумерация
      (1...column_count).each do |column_index|
        value = data_table.matrix[row_index][column_index]
        @view.table.setItemText(row_index, column_index, value.to_s)
      end
    end
  end

  
  # Удаление студентов
  def delete_selected_students
    selected_rows = @view.selected_rows
    selected_rows.each do |row_index|
      student_id = @view.table.getItemText(row_index, 0).to_i
      @student_list.delete_student_by_id(student_id)
    end
    refresh_data(@view.current_page)
  end

  def add_student(student)
    @student_list.db.add_student(student)
    refresh_data
  end

  def update_student(student_id, updated_student)
    if updated_student
      @student_list.db.replace_student_by_id(student_id, updated_student)
      refresh_data
    end
  end
end
