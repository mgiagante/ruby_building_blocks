# This Caesar Cipher implementation uses a Ring enumerator wrapper that handles end of iteration by rewinding its enumerator to achieve the circular iteration behavior.
class Ring
  def initialize(collection)
    @enum = collection.each
  end

  def next
    begin
      @enum.next
    rescue StopIteration
      @enum.rewind.next
    end
  end
end

def caesar_cipher(message, shift_factor)
  message.split('').map { |char| displaced_char(char, shift_factor) }.join
end

private

def displaced_char(char, number)
  if /[A-Z]/ =~ char # Use a differente range to initialize the ring, according to the case of the letter being displaced
    letters = Ring.new('A'..'Z')
  elsif /[a-z]/ =~ char
    letters = Ring.new('a'..'z')
  else
    return char # If the character is not a letter, return it untouched
  end

  current_letter = letters.next
  until current_letter == char do # Iterate over the enum until finding the character to displace
    current_letter = letters.next
  end
  number.times { current_letter = letters.next } # From the target char, find out which char is 'number' positions beyond circularly
  current_letter
end

puts 'Enter a message:'
content = gets.chomp

puts caesar_cipher(content, 5)
