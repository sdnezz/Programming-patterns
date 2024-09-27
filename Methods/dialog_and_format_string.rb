#8 Вариант Дука В. 39/2
#Знакомство с Ruby
puts 'Hello, World!'
#Запрашиваем имя пользователя или передаем аргумент ARGV cmd строки по умолчанию если не пуст
if ARGV.empty?
	puts "Как можно к вам обращаться?"
	username = gets.chomp
	#Удаляем пробел и перенос, если строка оказывается пуста, то аргумент - переменная окружения
	if username.strip.empty?
		username = ENV["USERNAME"]
	end
else
	#если символ cmd строки пустой - переменная окружения - иначе ARGV[0] станет именем пользователя
	username = ARGV[0].strip.empty? ? ENV["USERNAME"]: ARGV[0]
end
ARGV.clear
#Приветствие пользователя с помощью форматирования строки

puts "Привет, #{username}, какой твой любимый язык программирования?"
favourite_language = gets.chomp

#Условные операторы для определения любимого ЯП пользователя
if favourite_language == "ruby" || favourite_language == "Ruby"
	puts "#{username} - подлиза"
elsif favourite_language == "python" ||  favourite_language == "Python"
	puts "Как необычно, но скоро будет Ruby ;)"
elsif favourite_language == "c#" || favourite_language == "C#" || favourite_language == "шарп"
	puts "Похвально, но скоро будет Ruby!"
elsif favourite_language == "pascal" || favourite_language == "Pascal"
	puts "0_o...скоро будет Ruby..."
elsif favourite_language == "C++" || favourite_language == "c++"
	puts "Ммммм... cкоро будет Ruby!"
else puts "Не слышал, но не важно - скоро будет Ruby!"
end

#Выполнение пользовательской команды Ruby и ОС
puts username + ", введи команду Ruby, которую хочешь выполнить"
ruby_command = gets.chomp.to_s
eval(ruby_command)
puts "Теперь, мой дорогой #{username}, введи ОС команду для выполнения"
os_command = gets.chomp.to_s
system(os_command)