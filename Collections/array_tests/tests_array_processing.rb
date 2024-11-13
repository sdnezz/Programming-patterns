# Тестирование класса
require 'minitest/autorun'
require '../blocks_methods/array_processing.rb'
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

  def test_max_by
    max = @processor.max_by { |x| -x }
    assert_equal 1, max
  end
  
  def test_sort_by
    sorted = @processor.sort_by { |x| -x }
    assert_equal [5, 4, 3, 2, 1], sorted
  end

  def test_reject
    rejected = @processor.reject { |x| x.even? }
    assert_equal [1, 3, 5], rejected
  end

  def test_cycle
    result = []
    @processor.cycle(2) { |x| result << x }
    assert_equal [1, 2, 3, 4, 5, 1, 2, 3, 4, 5], result
  end
end