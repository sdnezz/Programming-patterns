require_relative 'data_table'
data_table1 = DataTable.new([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

puts "Элемент 1 строки 2 столбца: #{data_table1[1,2]}"
puts data_table1
puts "Количество строк в матрице: #{data_table1.count_rows}"
puts "Количество столбцов в матрице: #{data_table1.count_columns}"