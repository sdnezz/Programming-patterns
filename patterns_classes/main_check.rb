require_relative 'data_table'
require_relative 'data_list'

data_table1 = DataTable.new([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

puts "Элемент 1 строки 2 столбца: #{data_table1[1,2]}"
puts data_table1
puts "Количество строк в матрице: #{data_table1.count_rows}"
puts "Количество столбцов в матрице: #{data_table1.count_columns}"

data_list1 = DataList.new(['Hello', 'World'])
data_list2 = DataList.new([20, 2025, 30, 1])
puts data_list1[1]
puts data_list1
puts
puts data_list2[2]
puts data_list2

data_list2.select(1)
puts "Выбранные элементы #{data_list2.get_selected}"