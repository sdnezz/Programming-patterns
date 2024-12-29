require 'pg'

def connect_to_db(host:, username:, database:, password:)
  PG.connect(host: host, user: username, dbname: database, password: password)
end

def create_students(client, create_filepath)
  create_command = File.read(create_filepath)
  client.exec(create_command)
  puts "Таблица создана успешно."
end

def insert_into_students(client, insert_filepath)
  insert_command = File.read(insert_filepath)
  client.exec(insert_command)
  puts "Данные добавлены успешно."
end

def select_from_students(client)
  result = client.exec('SELECT * FROM student;')
  puts "Данные из таблицы student:"
  result.each do |row|
    puts row
  end
end

# Подключаемся к базе данных
client = connect_to_db(host: 'localhost', username: 'postgres', database: 'student_db', password: 123)

# Создаем таблицу
create_students(client, 'structure/create_student_table.txt')

# Заполняем таблицу данными
insert_into_students(client, 'structure/data_students.txt')

# Выполняем SELECT запрос
select_from_students(client)