require 'pg'

class StudentDBOperations
  attr_accessor :client

  def initialize(host:, username:, password:, database:)
    @client = nil
    10.times do |attempt|
      begin
        @client = PG.connect(host: host, user: username, password: password, dbname: database)
        puts "Успешное подключение на попытке #{attempt + 1}"
        break
      rescue PG::Error => e
        puts "Ошибка подключения на попытке #{attempt + 1}: #{e.message}"
        sleep(1)
      end
    end
    raise PG::ConnectionBad, "Не удалось подключиться к базе данных" if @client.nil?
  end

  private :client=

  def select_student_by_id(required_id)
    @client.exec_params("SELECT * FROM student WHERE id = $1;", [required_id]).first
  end

  def select_k_n_students(page:, amount_rows: 20)
    offset = (page - 1) * amount_rows
    @client.exec_params("SELECT * FROM student LIMIT $1 OFFSET $2;", [amount_rows, offset]).to_a
  end

  def insert_student(student)
    @client.exec_params(
      "INSERT INTO student (first_name, last_name, middle_name, birthdate, phone, telegram, email, git) VALUES ($1, $2, $3, $4, $5, $6, $7, $8);",
      [student.first_name, student.last_name, student.middle_name, student.birthdate, student.phone, student.telegram, student.email, student.git]
    )
  end

  def update_student_by_id(required_id, new_student)
    @client.exec_params(
      "UPDATE student SET first_name = $1, last_name = $2, middle_name = $3, birthdate = $4, phone = $5, telegram = $6, email = $7, git = $8 WHERE id = $9;",
      [new_student.first_name, new_student.last_name, new_student.middle_name, new_student.birthdate, new_student.phone, new_student.telegram, new_student.email, new_student.git, required_id]
    )
  end

  def delete_student_by_id(required_id)
    @client.exec_params("DELETE FROM student WHERE id = $1;", [required_id])
  end

  def get_student_count
    result = @client.exec("SELECT COUNT(*) FROM student;")
    result.getvalue(0, 0).to_i
  end

  def close
    @client.close if @client
    puts "Соединение с базой данных закрыто"
  end
end
