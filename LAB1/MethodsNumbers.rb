#методы для работы с числом варианта №8 задания 4
#Метод для нахождения количества взаимно простых чисел с заданным
def count_of_coprime_numbers(number)
  	count = 0
  	(1..number).each do |i|
    	#Алгоритм для нахождения наибольшего общего делителя
    	main_number, cycle_number = number, i
    	while cycle_number != 0
      		main_number, cycle_number = cycle_number, main_number % cycle_number
    	end
    	#Если НОД равен 1, то прибавляем к счетчику количества чисел
    	count += 1 if main_number == 1
  	end
  	count
end

#Метод для нахождения суммы цифр числа, делящихся на 3
def sum_of_digits_div_by_3(number)
	sum_answer = 0
	memory_number = 0
	#Дробление числа на цифры с помощью деления с остатком и переприсвоения делением без остатка на 10
	while number != 0
		memory_number = number % 10
		#Если цифра делится на 3, то считаем сумму
		if (memory_number %3 == 0)
			sum_answer = sum_answer + memory_number
		end
		number = number / 10
	end
	sum_answer
end

#Метод для нахождения делителя числа явл-ся взаимно простым с наиб. кол. цифр данного числа
def divisor_coprime_largest_count_numbers(original_number)
	#Создаем массив для цифр числа и заполняем его
	array_of_numbers = []
	memory_number = 0
	number = original_number
	while number != 0
		memory_number = number % 10
		number = number / 10
		#заполняем массив, добавляя цифры в его начало для наглядности
		array_of_numbers.prepend(memory_number)
	end
	
	#Функция нахождения НОД с передаваемыми делителем и цифрой из массива
	# def NOD_Euclid(number_devisor, digit_of_number)
	# 	while number_divisor != digit_of_number
	# 		if number_divisor > digit_of_number
	# 			number_divisor -= digit_of_number
	# 		else 
	# 			digit_of_number -= number_divisor
	# 		end
	# 	end
	# 	digit_of_number
	# end
	#Рекурсивный вариант метода Евклида с помощью тернарного оператора
	def NOD_Euclid(number_divisor, digit_of_number)
		#Если цифра != 0, значит НОД равен делителю числа, иначе рекурсивно использовать новое значение первого числа и % остаток от делителя и цифры
    	digit_of_number == 0 ? number_divisor : NOD_Euclid(digit_of_number, number_divisor % digit_of_number)
  	end
	
	#Функция проверки на взаимную простоту с помощью НОД: если равен 1, то переходим
	def coprime?(number_divisor,digit_of_number)
		NOD_Euclid(number_divisor,digit_of_number)==1
	end

	#Собираем в массив делители числа перебором без единицы до number и проверкой на делимость
	# divisors = (1..number).select {|possible_divisor| number % possible_divisor == 0}
	divisors = []
	(1..original_number).each do |posible_divisor|
		if original_number % posible_divisor == 0
			divisors.prepend(posible_divisor)
		end
	end
	puts "Найдены делители: #{divisors.inspect}"
	#Поиск подходящего делителя с наибольшим кол-ом взаимной простоты с цифрами числа
	max_coprime = 0
	answer_divisor = divisors.first
	divisors.each do |divisor|
		#Подсчет удовлетворяющих условию взаимно простых пар делителя и цифр методом count  массива
		coprime_count = array_of_numbers.count{|digit| coprime?(divisor, digit)}
		if coprime_count > max_coprime
			max_coprime = coprime_count
			answer_divisor = divisor
		elsif coprime_count == max_coprime && divisor > answer_divisor
			answer_divisor = divisor
		end
	end
	answer_divisor
end

#Диалог с пользователем для ввода числа для работы с методами
puts "Введите число для работы с методами"
number = gets.chomp.to_i
puts "Количество взаимно простых чисел с заданным: \n", count_of_coprime_numbers(number)
puts "Сумма цифр числа, делящихся на 3: ",sum_of_digits_div_by_3(number)
puts "Делитель числа, являющийся взаимно простым с наибольшим количеством цифр заданного числа: ", divisor_coprime_largest_count_numbers(number)