module Enumerable
  def my_each
    if block_given?
      enum = self.to_enum 
      loop do
        begin
          yield enum.next
        rescue StopIteration
          break  
        end
      end
      self
    else
      self.to_enum(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      enum = self.to_enum(:my_each).with_index
      loop do
        begin
          iteration = enum.next
          item, index = iteration[0], iteration[1] 
          yield item, index 
        rescue StopIteration
          break  
        end
      end
      self
    else
      self.to_enum(:my_each).with_index
    end
  end

  def my_select
    if block_given?
      selection = self.class.new
      self.my_each { |item| selection << item if yield item }
      selection
    else
      self.to_enum(:my_select)
    end
  end

  def my_all?
    result = true 
    if block_given?
      self.each { |item| result = result && yield(item) }
    else
      self.each { |item| result = result && (item ? true : false) }
    end
    result
  end

  def my_any?
    result = false
    if block_given?
      self.each { |item| result = result || yield(item) }
    else
      self.each { |item| result = result || (item ? true : false) }
    end
    result
  end

  def my_none?(&block)
    !self.my_any?(&block)
  end

  def my_count
    self.my_each.size
  end

  def my_map(callable = nil)
    return self.to_enum(:my_map) unless callable || block_given?

    results = self.class.new

    self.my_each do |item|
      results << (callable ? callable.call(item) : yield(item))
    end

    results
  end

  def my_inject(initial_value = nil)
    raise ArgumentError, "Block expected!" unless block_given?

    if initial_value
      result = initial_value 
      self.each { |item| result = yield(result, item) }
      result
    else
      temporary_copy = self.dup
      result = temporary_copy.shift # Remove the first element and store it in result
      temporary_copy.each { |item| result = yield(result, item) }
      result
    end
  end
end

# Method to test #my_inject
def multiply_els(array)
  array.my_inject { |total, number| total * number }
end
