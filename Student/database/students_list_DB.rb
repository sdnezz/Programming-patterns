require_relative 'student_db_operations'
require_relative '../student'
require_relative '../student_short'
require_relative '../../patterns_classes/data_list_student_short'

class StudentsListDB
  attr_accessor :client_db

  def initialize(host:, username:, password:, database:)
    self.client_db = StudentDBOperations.get_instance(
      host: host,
      username: username,
      password: password,
      database: database
    )
  end

  private :client_db

  # Получение объекта Student по ID
  def get_student_by_id(required_id)
    student_hash = self.client_db.select_student_by_id(required_id)
    return nil if student_hash.nil?

    Student.create_from_hash(student_hash.transform_keys(&:to_sym))
  end

  # Получение страницы объектов StudentShort
  def get_k_n_student_short_list(page:, amount_rows: 20)
    student_array = self.client_db.select_k_n_students(page: page, amount_rows: amount_rows)
    student_short_array = student_array.map do |student|
      StudentShort.new_from_student(Student.create_from_hash(student.transform_keys(&:to_sym)))
    end
    DataListStudentShort.new(student_short_array)
  end

  # Добавление нового студента
  def add_student(student)
    self.client_db.insert_student(student)
  end

  # Замена студента по ID
  def replace_student_by_id(required_id, new_student)
    self.client_db.update_student_by_id(required_id, new_student)
  end

  # Удаление студента по ID
  def delete_student_by_id(required_id)
    self.client_db.delete_student_by_id(required_id)
  end

  # Получение общего количества студентов
  def get_student_count
    self.client_db.get_student_count
  end

  def get_sorted_students(column, order)
    query = "SELECT * FROM students ORDER BY #{column} #{order.to_s.upcase}"
    result = @db.exec(query)
    result.map do |row|
      Student.new(
        id: row['id'].to_i,
        first_name: row['first_name'],
        last_name: row['last_name'],
        middle_name: row['middle_name'],
        git: row['git'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        birthdate: row['birthdate']
      )
    end
  end

  def get_filtered_students(filter_conditions, filter_texts)
    conditions = []
    values = []

    filter_conditions.each do |key, condition|
      case condition
      when 1 # Да
        conditions << "#{key} IS NOT NULL AND #{key} != ''"
      when 2 # Нет
        conditions << "#{key} IS NULL OR #{key} = ''"
      end
    end

    filter_texts.each do |key, text|
      unless text.empty?
        conditions << "#{key} ILIKE ?"
        values << "%#{text}%"
      end
    end

    where_clause = conditions.empty? ? '' : "WHERE #{conditions.join(' AND ')}"
    query = "SELECT * FROM students #{where_clause}"

    result = @db.exec_params(query, values)
    result.map do |row|
      Student.new(
        id: row['id'].to_i,
        first_name: row['first_name'],
        last_name: row['last_name'],
        middle_name: row['middle_name'],
        git: row['git'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        birthdate: row['birthdate']
      )
    end
  end

  # Выполнение кастомного SQL-запроса
  def custom_query(query)
    self.client_db.custom_query(query)
  end

  # Закрытие соединения
  def close_connection
    self.client_db.close
  end
end
