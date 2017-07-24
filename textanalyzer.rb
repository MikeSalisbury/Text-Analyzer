stopwords = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV[0])
line_count = lines.length
text = lines.join
total_characters = text.length
total_characters_no_spaces = text.gsub(/s+/, '').length
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length
sentences_per_paragraph = sentence_count / paragraph_count
words_per_sentence = word_count / sentence_count
useful_words = text.scan(/\w+/).select { |word| !stopwords.include?(word) }.length
useful_word_percent = (useful_words.to_f / word_count) * 100

#will find ideal 'at-a-glance' sentences
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sorted_sentences = sentences.sort_by { |sentence| sentence.length }
one_third = sorted_sentences.length / 3
ideal_sentences = sorted_sentences.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select {|sentence| sentence =~ /is|are/}

p "#{line_count} lines"
p "#{total_characters} characters"
p "#{total_characters_no_spaces} characters excluding spaces"
p "#{word_count} words"
p "#{sentence_count} sentences"
p "#{paragraph_count} paragraphs"
p "#{sentences_per_paragraph} sentence per paragraph on average"
p "#{words_per_sentence} words per sentence on average"
p "#{useful_words} useful words in this text"
p "#{useful_word_percent.round} percent of words are useful"
puts "Summary:\n\n" + ideal_sentences.join(". ")
p "-- End of Analysis"
