module NaiveBayesClassifier
	module BagOfWords
		class Vocabulary
			attr_reader :data

			def initialize(examples) 
				@examples = examples
				@data = build_vocabulary
			end

			def include?(klass)
				@data.keys.include?(klass)
			end

			def words_count_of(klass)
				#TODO: refactoring to use sum
				total = 0
				@data[klass].each_pair do |k,v|
					total += v
				end
				total
			end

			def number_of_words
				total = 0
				@data.keys.each do |klass|
					total += words_count_of(klass)
				end
				total
			end

			def words(sentence)
				ngram = NaiveBayesClassifier::BagOfWords::NgramModel.new(sentence)
				words = []
				ngram.unigram.each_pair do |key,value|
					1.upto(value) do 
						words << key
					end
				end
				words
			end

			def count_of(feature,klass)
				element = @data[klass].select {|word| word == feature}
				return 0 if element.empty?
				element[feature]
			end

			def  number_of_classes
				@data.keys.count
			end

			private 
			def build_vocabulary
				data = {}
				@examples.each_pair do |key, value|
					sentence = value.join(' ')
					ngram = NaiveBayesClassifier::BagOfWords::NgramModel.new(sentence)
					data[key] = ngram.unigram
				end
				data
			end

		end
	end
end