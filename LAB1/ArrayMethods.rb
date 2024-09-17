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

#Тестовый список для проверки методов
array_of_number = [-2,-30,7,2,0,15,12,8,-80]
#Вывод результатов поиска минимального, максимального и первого положит. эл. соответственно
minimal_element_in_list = min_element_in_list(array_of_number)
maximal_element_in_list = max_element_in_list(array_of_number)
number_first_positive_element_in_list = num_first_pos_el(array_of_number)
puts "Минимальный элемент списка:", minimal_element_in_list
puts "Максимальный элемент списка:", maximal_element_in_list
puts "Номер первого положительного элемента в списке:", number_first_positive_element_in_list