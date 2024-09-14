#методы для работы с числом варианта №8 задания 4
#Метод для нахождения количества взаимно простых чисел с заданным
def count_of_coprime_numbers(number)
  	count = 0
  	(1..number).each do |i|
    	#Алгоритм для нахождения наибольшего общего делителя
    	main_number = number
    	cycle_number = i
    	while cycle_number != 0
      		temp = cycle_number
      		cycle_number = main_number % cycle_number
      		main_number = temp
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

#def divisor_coprime_largest_count_numbers(number)
#end

#Диалог с пользователем для ввода числа для работы с методами
puts "Введите число для работы с методами"
number = gets.chomp.to_i
puts count_of_coprime_numbers(number)
puts sum_of_digits_div_by_3(number)