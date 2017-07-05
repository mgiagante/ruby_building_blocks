def substrings(string_with_words, dictionary)
  words = string_with_words.split(/\W/).reject { |word| word.empty? }
  words.map! { |word| word.downcase }
  words.map! do |word|
    ['s', 't'].include?(word) ? expand(word) : word
  end

  occurrences = Hash.new(0)
  dictionary.each do |substring|
    words.each do |word|
      occurrences[substring] += 1 if word.include?(substring) 
    end
  end
  occurrences
end

private

def expand(letter)
  mapping = {s: 'is', t: 'not'}
  mapping[letter.to_sym]
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)
