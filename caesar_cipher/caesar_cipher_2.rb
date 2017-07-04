def caesar_cipher(text, factor)
  lowercase_letters = ('a'..'z').to_a
  lowercase_mappings = displacement_mapping_for(lowercase_letters, factor)
  uppercase_letters = ('A'..'Z').to_a
  uppercase_mappings = displacement_mapping_for(uppercase_letters, factor)
  
  text.each_char.inject do |encoded_text, char| 
    char_to_add = if char =~ /[a-z]/
      lowercase_mappings[char]
    elsif char =~ /[A-Z]/
      uppercase_mappings[char]
    else
      char
    end
    encoded_text + char_to_add
  end
end

private

def displacement_mapping_for(letters, positions)
  rotated_letters = letters.rotate(positions)
  nested_mapping = letters.zip(rotated_letters)
  Hash[nested_mapping] 
end

puts "Enter a message: "
text = gets.chomp
puts caesar_cipher(text, 5)
