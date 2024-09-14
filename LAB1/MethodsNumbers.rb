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

puts "Введите число для работы с методами"
number = gets.chomp.to_i
puts count_of_coprime_numbers(number)

#def sum_of_digits_div_by_3(number)
#end
#def divisor_coprime_largest_count_numbers(number)
#end
