require 'json'

str = ARGV[0]
test_letters = str.split('')
required_letter = test_letters.first
all_letters = ('a'..'z').to_a
bad_letters = all_letters.difference(test_letters)

(4..12).each do |i|
  words = []
  wordlist = JSON.parse(File.read("word_lists/#{i}_letter.json"))
  wordlist.each { |entry| words << entry["word"] }

  words.map! { |word| word if (word.include? required_letter) &&
                               word.split('').difference(bad_letters).size == word.split('').size }

  words.reject!(&:nil?)
  puts words
end
