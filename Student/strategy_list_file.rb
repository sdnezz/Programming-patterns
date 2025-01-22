class StorageStrategy
  def read_from_file(filepath)
    raise NotImplementedError, 'Метод должен быть переопределён в подклассе'
  end

  def write_to_file(filepath, student_array)
    raise NotImplementedError, 'Метод должен быть переопределён в подклассе'
  end
end