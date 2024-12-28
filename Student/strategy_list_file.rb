class StrategyListFile
  def read_from_file(filepath)
    raise NotImplementedError, 'Метод read_from_file должен быть реализован в подклассе'
  end

  def write_to_file(filepath, student_array)
    raise NotImplementedError, 'Метод write_to_file должен быть реализован в подклассе'
  end
end
