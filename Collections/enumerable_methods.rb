# 8 Найти индексы двух наименьших элементов
def two_smallest_element_index(arr)
  arr.each_with_index.min_by(2) { |value, _| value }.map { |_, idx| idx }
end

# Выбор метода для выполнения и пути загрузки массива
if ARGV.length == 2
  number_of_method = ARGV[0].to_i
  filepath_of_array = ARGV[1]
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
  elsif input_method == 'вручную'
    puts "Введите массив чисел через пробел:"
    array_from_file = gets.chomp.split.map(&:to_i)
  else
    raise ArgumentError, "Неверный метод ввода. Используйте 'файл' или 'вручную'."
  end
end

# Если выбран ввод через файл, проверяем его наличие и загружаем массив
if defined?(filepath_of_array)
  unless File.exist?(filepath_of_array)
    raise ArgumentError, "Файл '#{filepath_of_array}' не найден"
  end
  opened_file = File.read(filepath_of_array)
  array_from_file = opened_file.split.map(&:to_i)
end

# Проверка на пустоту массива
if array_from_file.empty?
  puts "Массив пуст"
else
  puts "Массив для обработки:"
  puts array_from_file.map(&:to_s).join(", ")

  # Выполнение выбранного метода
  case number_of_method
  when 1
    puts "Индексы двух наименьших элементов: #{two_smallest_element_index(array_from_file)}"
  when 2
    puts "Пропущенные числа: #{find_missing_numbers(array_from_file)}"
  when 3
    puts "Количество локальных максимумов: #{count_local_maximum(array_from_file)}"
  when 4
    puts "Чередование целых и вещественных чисел: #{alternating_integer_float?(array_from_file)}"
  when 5
    result = avg_non_prime_greater_than_avg_prime(array_from_file)
    if result
      puts "Среднее арифметическое непростых, превышающих среднее простых: #{result}"
    else
      puts "Нет элементов, соответствующих условиям."
    end
  else
    puts "Неверный номер задачи. Выберите от 1 до 5."
  end
end

# Очистка ARGV для предотвращения повторной обработки
ARGV.clear