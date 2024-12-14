class DataList
	attr_accessor :sorted_array
	private :sorted_array=

	  def initialize(array)
	    self.sorted_array = []
	    array.sort{|a, b| b <=> a}.each do |element|
	      self.sorted_array.append({value: element, selected: false})
	    end
  	end
	def [](index)
		self.sorted_array[index]
	end
	def to_s
		self.sorted_array.to_s
	end

	def select(index)
		self.sorted_array[index-1][:selected] = true
	end

	def get_selected
    	self.sorted_array.find_all{|element| element[:selected] == true}
  	end

	protected def get_names
		#Возвращаем массив всех переменных экземпляра
	    obj_fields = self.sorted_array.first.instance_variables
	    return obj_fields.delete(:@id)
  	end
end