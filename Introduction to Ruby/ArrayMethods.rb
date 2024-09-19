#Задание 5 - методы для работы с array 
#Метод нахождения минимального элемента списка
def min_element_in_list(array)
	#Поиск при условии, что список не пуст
	if array.empty?
		return puts "Список пуст"
	else
		min_element = array[0]
		for array_element in array
			if array_element < min_element
				min_element = array_element
			end
		end
	end
	min_element
end
#Метод для нахождения максимального элемента списка
def max_element_in_list(array)
	#Поиск при условии, что список не пуст
	if array.empty?
		return puts "Список пуст"
	else
		max_element = array[0]
		for array_element in array
			if array_element > max_element
				max_element = array_element
			end
		end
	end
	max_element
end
#Метод для нахождения номера первого положительного элемента в списке
def num_first_pos_el(array)
	#Поиск при условии, что список не пуст
	if array.empty?
		return puts "Список пуст"
	else
		value_index = 0
		while value_index < array.length
			if array[value_index] >= 0 
				#прибавляем +1 для привычной для обычного пользователя нумерации
				return value_index+1
				break
			end
			value_index += 1
		end
		#Если не найден ни один положительный элемент
	return "В списке нет положительных элементов"
	end
end

#Программа, принимающая номер метода и путь к файлу, как два аргумента
def choise_of_method(num_method,array)
	if(array.empty?)
		puts "Массив пуст (проверьте доступ к файлу или целостность содержимого)"
	else
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

	#Передаем аргументы и выполняем метод
	choise_of_method(number_of_method,array_from_file)
end