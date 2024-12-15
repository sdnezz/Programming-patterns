# Базовый класс
class AthleteTraining
  attr_accessor :stamina

  def initialize
    self.stamina = 100
  end

  # Общий алгоритм тренировки
  def train
    warm_up
    main_workout
    cool_down
    recover
    puts "Уровень выносливости после тренировки: #{stamina}/100\n\n"
  end

  # Общие этапы тренировки
  def warm_up
    self.stamina -= 10
    puts "Разминка завершена. Уменьшение выносливости на 10."
  end

  def cool_down
    self.stamina -= 5
    puts "Заминка завершена. Уменьшение выносливости на 5."
  end

  def recover
    self.stamina += 20
    puts "Восстановление завершено. Увеличение выносливости на 20."
  end

  # Абстрактный метод для главного упражнения
  def main_workout
    raise NotImplementedError, "Метод main_workout должен быть реализован в подклассе"
  end
end

# Подкласс для бегунов
class RunnerTraining < AthleteTraining
  def main_workout
    self.stamina -= 50
    puts "Бег на 10 км завершён. Уменьшение выносливости на 50."
  end
end

# Подкласс для пловцов
class SwimmerTraining < AthleteTraining
  def main_workout
    self.stamina -= 40
    puts "Плавание 2 км завершено. Уменьшение выносливости на 40."
  end

  # Переопределим восстановление для пловцов
  def recover
    self.stamina += 25
    puts "Восстановление пловца завершено. Увеличение выносливости на 25."
  end
end

# Главный метод
def main
  begin
    puts "Тренировка бегуна:"
    runner = RunnerTraining.new
    runner.train

    puts "Тренировка пловца:"
    swimmer = SwimmerTraining.new
    swimmer.train
  rescue => e
    puts e.message
  end
end

main
