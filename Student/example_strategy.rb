# Интерфейс стратегии
class PaymentStrategy
  def pay(amount)
    raise NotImplementedError, 'Метод должен быть переопределён в подклассе'
  end
end

# Конкретная стратегия: оплата наличными
class CashPayment < PaymentStrategy
  def pay(amount)
    puts "Оплата #{amount} рублей наличными выполнена."
  end
end

# Конкретная стратегия: оплата картой
class CardPayment < PaymentStrategy
  def pay(amount)
    puts "Оплата #{amount} рублей с помощью карты выполнена."
  end
end

# Конкретная стратегия: оплата через онлайн-платёж
class OnlinePayment < PaymentStrategy
  def pay(amount)
    puts "Оплата #{amount} рублей через онлайн-платёж выполнена."
  end
end

# Контекст: магазин, который принимает оплату
class Store
  attr_accessor :payment_strategy

  def initialize(payment_strategy)
    @payment_strategy = payment_strategy
  end

  def checkout(amount)
    @payment_strategy.pay(amount)
  end
end

# Покупатель выбирает способ оплаты
store = Store.new(CashPayment.new)
store.checkout(1000)

store.payment_strategy = CardPayment.new
store.checkout(2500)

store.payment_strategy = OnlinePayment.new
store.checkout(5000)