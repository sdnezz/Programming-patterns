# 8 Найти индексы двух наименьших элементов
def two_smallest_element_index(arr)
  arr.each_with_index.min_by(2) { |value, _| value }.map { |_, idx| idx }
end

# 20. Найти все пропущенные числа в массиве
def find_missing_numbers(arr)
  (arr.min..arr.max).to_a - arr
end

# Выбор метода для выполнения и пути загрузки массива
if ARGV.length == 2
  number_of_method = ARGV[0].to_i
  filepath_of_array = ARGV[1]
  ARGV.clear
else
  puts "Введите номер задачи для работы со списком:"
  puts "1) Индексы двух наименьших элементов"
  puts "2) Найти все пропущенные числа"
  puts "3) Найти количество локальных максимумов"
  puts "4) Проверить чередование целых и вещественных чисел"
  puts "5) Среднее арифметическое непростых, превышающих среднее простых"
  number_of_method = gets.chomp.to_i
  puts "Вы хотите загрузить массив из файла или ввести вручную? (Введите 'файл' или 'вручную')"
  input_method = gets.chomp.downcase

  if input_method == 'файл'
    puts "Введите путь к файлу со списком в формате <название.txt>:"
    filepath_of_array = gets.chomp
    unless File.exist?(filepath_of_array)
      raise ArgumentError, "Файл '#{filepath_of_array}' не найден"
    end
    opened_file = File.read(filepath_of_array)
    array = opened_file.split.map(&:to_i)
  elsif input_method == 'вручную'
    puts "Введите массив чисел через пробел:"
    array = gets.chomp.split.map(&:to_i)
  else
    raise ArgumentError, "Неверный метод ввода. Используйте 'файл' или 'вручную'."
  end
end

# Проверка на пустоту массива
if array.empty?
  puts "Массив пуст"
else
  puts "Массив для обработки:"
  puts array.map(&:to_s).join(", ")

  # Выполнение выбранного метода
  case number_of_method
  when 1
    puts "Индексы двух наименьших элементов: #{two_smallest_element_index(array)}"
  when 2
    puts "Пропущенные числа: #{find_missing_numbers(array)}"
  when 3
    puts "Количество локальных максимумов: #{count_local_maximum(array)}"
  when 4
    puts "Чередование целых и вещественных чисел: #{alternating_integer_float?(array)}"
  when 5
    result = avg_non_prime_greater_than_avg_prime(array)
    if result
      puts "Среднее арифметическое непростых, превышающих среднее простых: #{result}"
    else
      puts "Нет элементов, соответствующих условиям."
    end
  else
    puts "Неверный номер задачи. Выберите от 1 до 5."
  end
end