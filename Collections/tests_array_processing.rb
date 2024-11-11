# Тестирование класса
require 'minitest/autorun'
require_relative 'array_processing'
class ArrayProcessingTest < Minitest::Test
  def setup
    @array = [1, 2, 3, 4, 5]
    @processor = ArrayProcessing.new(@array)
  end

  def test_elements
    assert_equal [1, 2, 3, 4, 5], @processor.array
  end

  def test_each_slice
    result = []
    @processor.each_slice(2) { |slice| result << slice }
    assert_equal [[1, 2], [3, 4], [5]], result
  end

# Реализация max_by
  def max_by
    return enum_for(:max_by) unless block_given?
    max_element = nil
    max_value = nil
    @array.each do |element|
      value = yield(element)
      if max_element.nil? || value > max_value
        max_element = element
        max_value = value
      end
    end
    max_element
  end
  
end