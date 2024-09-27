#Задание 5 - методы для работы с array 
#Метод нахождения минимального элемента списка
def min_element_in_list(array)
	min_element = array[0]
	for array_element in array
		if array_element < min_element
			min_element = array_element
		end
	end
	min_element
end
#Метод для нахождения максимального элемента списка
def max_element_in_list(array)
	max_element = array[0]
	for array_element in array
		if array_element > max_element
			max_element = array_element
		end
	end
	max_element
end
#Метод для нахождения номера первого положительного элемента в списке
def num_first_pos_el(array)
	value_index = 0
	while value_index < array.length
		if array[value_index] > 0 
			#прибавляем +1 для привычной для обычного пользователя нумерации
			return value_index+1
		end
		value_index += 1
	end
end

#Программа, принимающая номер метода и путь к файлу, как два аргумента
def choise_of_method(num_method,array)
	case num_method
	when 1
		puts "Минимальный элемент списка: #{min_element_in_list(array)}"
	when 2
		puts "Максимальный элемент списка: #{max_element_in_list(array)}"
	when 3
		puts "Первый положительный элемент списка: #{num_first_pos_el(array)}"
	else
		puts "Выбран несуществующий номер метода"
	end
end

#Выбор пользователем метода и пути к файлу со списком, как аргументов
if ARGV.length == 2
	number_of_method = ARGV[0].to_i
	filepath_of_array = ARGV[1]
else
	puts "Введите номер метода для работы со списком:"
	puts "1) Метод для нахождения минимального элемента списка"
	puts "2) Метод для нахождения максимального элемента списка"
	puts "3) Метод для нахождения номера первого положительного элемента в списке"
	number_of_method = gets.chomp.to_i
	puts "Введите путь к файлу со списком в формате <название.txt>:"
	filepath_of_array = gets.chomp
end

begin
	#Задаем 2 переменные для просмотра содержимого файла и разбития на массив
	opened_file = File.read(filepath_of_array)
	array_from_file = opened_file.split.map{|not_int_array_element| not_int_array_element.to_i }
	#Выполняем поиск после проверки на пустоту массива
	if(!array_from_file.empty?)
		array_from_file.each do |element|
		puts element
		end
		#Передаем аргументы и выполняем метод
		choise_of_method(number_of_method,array_from_file)
	else
		puts "Массив пуст"
	end
end