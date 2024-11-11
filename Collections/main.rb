require_relative 'array_processing'

# Создаем экземпляр класса ArrayProcessing
array_processor = ArrayProcessing.new([1, 2, 3, 4, 5, 6, 7])

puts "each_slice:"
array_processor.each_slice(3) do |slice|
  p slice
end

puts "\nmax_by:"
max_element = array_processor.max_by { |x| -x }
puts "Максимальный элемент (по возрастанию): #{max_element}"

puts "\nsort_by:"
sorted_array = array_processor.sort_by { |x| -x }
puts "Отсортированный массив по убыванию: #{sorted_array}"

puts "\nreject:"
rejected_array = array_processor.reject { |x| x.even? }
puts "Массив без четных элементов: #{rejected_array}"

begin
  puts "\nПроверка ошибки при инициализации с неправильным типом данных:"
  ArrayProcessing.new("строка а не массив бебебебебе")
rescue TypeError => e
  puts "#{e.message}"
end
# Ожидаемый вывод: Поймано исключение: Неверный тип входных данных
