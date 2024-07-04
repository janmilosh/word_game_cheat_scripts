require 'json'

group1 = ARGV[0].split('')
group2 = ARGV[1].split('')
group3 = ARGV[2].split('')
group4 = ARGV[3].split('')
first_letter = ARGV[4]
test_letters = group1 + group2 + group3 + group4
TEST_GROUPS = [group1, group2, group3, group4]
all_letters = ('a'..'z').to_a
BAD_LETTERS = all_letters.difference(test_letters)
possibilities = []

def match? word
  arr = word.split('')
  correct_letters?(arr) && no_double_letters?(arr) && good_neighbors?(arr)
end

def correct_letters? word_arr
  word_arr.difference(BAD_LETTERS).size == word_arr.size
end

def no_double_letters? word_arr
  (1..word_arr.size-1).each do |i|
    if word_arr[i] == word_arr[i - 1]
      return false
    end
  end
  true
end

def good_neighbors? word_arr
  (1..word_arr.size-1).each do |i|
    TEST_GROUPS.each do |group|
      if group.include?(word_arr[i]) && group.include?(word_arr[i - 1])
        return false
      end
    end
  end
  true
end

(4..12).each do |i|
  words = []
  wordlist = JSON.parse(File.read("word_lists/#{i}_letter.json"))
  wordlist.each { |entry| words << entry["word"] }

  words.map! do |word|
    if first_letter
      word if match?(word) && word.split('').first == first_letter
    else
      word if match?(word)
    end
  end

  words.reject!(&:nil?)
  possibilities << words
end

possibilities.flatten!.sort!
results = []

possibilities.each do |word1|
  possibilities.each do |word2|
    arr1 = word1.split('')
    arr2 = word2.split('')
    if (arr1 + arr2).uniq.sort == test_letters.sort && arr1.last == arr2.first
      results << [word1, word2]
    end
  end
end

results.map! { |result| result.sort }.uniq!
results.each { |result| puts "#{result.first}, #{result.last}" }
