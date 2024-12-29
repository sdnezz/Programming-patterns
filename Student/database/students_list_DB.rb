require 'pg'
require_relative '../student'
require_relative '../student_short'
require_relative '../../patterns_classes/data_list_student_short'

class StudentsListDB
  attr_accessor :client

  def initialize(host:, username:, password:, database:)
    self.client = PG.connect(host: host, user: username, password: password, dbname: database)
  end

  private :client=

  # Получение объекта Student по ID
  def get_student_by_id(required_id)
    result = self.client.exec_params("SELECT * FROM student WHERE id = $1;", [required_id]).first
    Student.create_from_hash(result.transform_keys(&:to_sym)) if result
  end

  # Получение списка объектов StudentShort
  def get_k_n_student_short_list(page:, amount_rows: 20)
    raise ArgumentError, 'Недопустимый номер страницы' if page <= 0
    raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

    offset = (page - 1) * amount_rows
    query = "SELECT id, last_name, first_name, middle_name, git, email, phone, telegram FROM student LIMIT $1 OFFSET $2;"
    result = self.client.exec_params(query, [amount_rows, offset])

    student_short_array = result.map do |row|
      StudentShort.new_from_student(Student.create_from_hash(row.transform_keys(&:to_sym)))
    end

    DataListStudentShort.new(student_short_array)
  end

  # Добавление нового студента
  def add_student(student)
    query = <<~SQL
      INSERT INTO student (first_name, last_name, middle_name, git, phone, telegram, email, birthdate)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING id;
    SQL
    result = self.client.exec_params(query, [
      student.first_name, student.last_name, student.middle_name, student.git,
      student.phone, student.telegram, student.email, student.birthdate
    ])
    result[0]['id'].to_i
  end

  # Замена студента по ID
  def replace_student_by_id(required_id, new_student)
    query = <<~SQL
      UPDATE student SET
        first_name = $1,
        last_name = $2,
        middle_name = $3,
        git = $4,
        phone = $5,
        telegram = $6,
        email = $7,
        birthdate = $8
      WHERE id = $9;
    SQL
    self.client.exec_params(query, [
      new_student.first_name, new_student.last_name, new_student.middle_name,
      new_student.git, new_student.phone, new_student.telegram,
      new_student.email, new_student.birthdate, required_id
    ])
  end

  # Удаление студента по ID
  def delete_student_by_id(required_id)
    self.client.exec_params("DELETE FROM student WHERE id = $1;", [required_id])
  end

  # Получение количества студентов
  def get_student_count
    result = self.client.exec("SELECT COUNT(*) AS count FROM student;")
    result[0]['count'].to_i
  end
end
