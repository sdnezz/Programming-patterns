class SingletonExample
  private_class_method :new

  @instance = nil #Это переменная экземпляра объекта Logger, который является экземпляром класса Class

  def self.instance
    @instance ||= new
  end

  def say_hello
    "Hello, Singleton!"
  end
end

# Проверка:
singleton1 = SingletonExample.instance
singleton2 = SingletonExample.instance

puts singleton1.object_id == singleton2.object_id # true (один объект)
puts singleton1.say_hello # "Hello, Singleton!"

class Parent
  @@instance = nil # Переменная класса (общая для всех подклассов)

  def self.instance
    @@instance ||= new
  end
end

class Child < Parent
end

parent_instance = Parent.instance
child_instance = Child.instance

puts parent_instance.object_id == child_instance.object_id # true (общий объект для всех)

