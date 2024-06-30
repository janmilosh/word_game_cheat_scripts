require "csv"

str = ARGV[0]
test_letters = str.split('')
required_letter = test_letters.first

words = []
CSV.foreach("word_lists/words_06_23.csv") do |row|
  words += row
end

words.reject!(&:nil?)
words.map!(&:downcase)

all_letters = ('a'..'z').to_a
bad_letters = all_letters.difference(test_letters)

words.map! { |word| word if (word.include? required_letter) &&
                             word.split('').difference(bad_letters).size == word.split('').size }

words.reject!(&:nil?)
puts words
