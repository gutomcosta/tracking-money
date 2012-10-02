module NaiveBayesClassifier
	class BayesRule

		def initialize(examples)
			@examples 		= examples
			@vocabulary  	= NaiveBayesClassifier::BagOfWords::Vocabulary.new(@examples)
			@probability 	= NaiveBayesClassifier::Probability::ProbabilityModel.new(@vocabulary)
		end

		def classify(instance)
			probabilities = {}
  		vocabulary.keys.each do |key|
    		probabilties[key] = bayes_rule(key,instance)
  		end
  		probabilities.max 
		end

		def bayes_rule(instance, klass)
			first_term = @probability.conditional(instance,klass) * @probability.prior(klass)
			first_term.to_f / (first_term.to_f + @probability.total_probability(instance, klass))
		end

	end
end