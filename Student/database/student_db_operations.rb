require 'pg'

class StudentDBOperations
  @instance = nil
  attr_accessor :connect

  # Приватный конструктор
  def initialize(host:, username:, password:, database:)
    self.connect = nil

    10.times do |attempt|
      begin
        self.connect = PG.connect(host: host, user: username, password: password, dbname: database)
        puts "Успешное подключение на попытке #{attempt}"
        break
      rescue PG::Error => error
        puts "Ошибка подключения на попытке #{attempt}: #{error.message}"
        sleep(1)
      end
    end

    raise PG::ConnectionBad, "Не удалось подключиться к базе данных" if self.connect.nil?
  end

  private_class_method :new
  private :connect=

  # Метод для получения единственного экземпляра класса
  def self.get_instance(host:, username:, password:, database:)
    @instance ||= new(host: host, username: username, password: password, database: database)
  end

  # Методы работы с базой данных
  def select_student_by_id(required_id)
    query = "SELECT * FROM student WHERE id = $1"
    result = self.connect.exec_params(query, [required_id])
    result.first
  end

  def select_k_n_students(page:, amount_rows: 20)
    raise ArgumentError, 'Недопустимый номер страницы' if page <= 0
    raise ArgumentError, 'Недопустимое количество записей' if amount_rows <= 0

    offset = (page - 1) * amount_rows
    query = "SELECT * FROM student LIMIT $1 OFFSET $2"
    result = self.connect.exec_params(query, [amount_rows, offset])
    result.to_a
  end

  def insert_student(student)
    query = <<-SQL
      INSERT INTO student (first_name, last_name, middle_name, birthdate, phone, telegram, email, git)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    SQL
    self.connect.exec_params(query, [
      student.first_name, student.last_name, student.middle_name, student.birthdate,
      student.phone, student.telegram, student.email, student.git
    ])
  end

  def update_student_by_id(required_id, new_student)
    query = <<-SQL
      UPDATE student
      SET first_name = $1, last_name = $2, middle_name = $3, birthdate = $4, 
          phone = $5, telegram = $6, email = $7, git = $8
      WHERE id = $9
    SQL
    self.connect.exec_params(query, [
      new_student.first_name, new_student.last_name, new_student.middle_name, new_student.birthdate,
      new_student.phone, new_student.telegram, new_student.email, new_student.git, required_id
    ])
  end

  def delete_student_by_id(required_id)
    query = "DELETE FROM student WHERE id = $1"
    self.connect.exec_params(query, [required_id])
  end

  def get_student_count
    query = "SELECT COUNT(*) AS count FROM student"
    result = self.connect.exec(query)
    result.first['count'].to_i
  end

  def custom_query(custom_query)
    self.connect.exec(custom_query)
  end

  def close
    self.connect.close
    puts "Соединение с базой данных закрыто"
  end
end
