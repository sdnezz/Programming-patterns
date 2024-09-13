#8 Вариант Дука В. 39/2
#Знакомство с Ruby
puts 'Hello, World!'
#Приветствие пользователя с помощью форматирования строки
username = ENV['USERNAME']
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