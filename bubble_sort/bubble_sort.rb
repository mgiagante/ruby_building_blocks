# This function has no side effects. It returns a new sorted version of the array given as argument.
def bubble_sort(array)
  new_array = array.dup
  last = new_array.size - 1
  swap_needed = true

  while swap_needed do
    current = 0
    swap_needed = false

    while (current < last) do
      if new_array[current] > new_array[current + 1]
        swap_needed = true
        new_array[current], new_array[current + 1] = new_array[current + 1], new_array[current]
      end
      current += 1
    end
  end
  new_array
end

def bubble_sort_by(array)
  new_array = array.dup
  last = new_array.size - 1
  swap_needed = true

  while swap_needed do
    current = 0
    swap_needed = false

    while current < last do
      comparison = yield(new_array[current], new_array[current + 1])
      if comparison > 0 
        swap_needed = true
        new_array[current], new_array[current + 1] = new_array[current + 1], new_array[current]
      end
      current += 1
    end
  end
  new_array
end

a = [4,3,78,2,0,2]

p bubble_sort a

p bubble_sort_by(a) { |smaller, bigger| smaller <=> bigger }
