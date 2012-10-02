module NaiveBayesClassifier
	module Probability
		class ProbabilityModel

			def initialize(vocabulary) 
				@vocabulary = vocabulary
			end

			def prior(klass)
				return 0 unless @vocabulary.include?(klass)
				puts "#{(@vocabulary.words_count_of(klass).to_f + 1)} / #{(@vocabulary.number_of_words.to_f + @vocabulary.number_of_classes.to_f)}"
				(@vocabulary.words_count_of(klass).to_f + 1) / (@vocabulary.number_of_words.to_f + @vocabulary.number_of_classes.to_f)
			end

			def conditional(instance, klass)
				features = @vocabulary.words(instance)
				value = 1
				features.each do |feature| 
					value = value * join_probability(feature,klass)
				end				
				value			
			end

			def total_probability(instance, klass_to_remove)
				total = 1
				@vocabulary.data.each_pair do |key,value|
					total = total * (conditional(instance, key) * prior(key)) unless key == klass_to_remove
				end
				total
			end

			def join_probability(feature,klass)
				feature_count = @vocabulary.count_of(feature, klass)
				klass_size    = @vocabulary.words_count_of(klass)
				(feature_count.to_f + 1) / (klass_size.to_f + @vocabulary.number_of_classes.to_f)
			end
		end
	end
end