module BayesClassifier
	class Classifier

		def initialize
			@classifier = Probability::BayesClassifier.new
		end

		def train(instance, concept)
			@classifier.train(concept, instance)
		end

		def classify(instance)
			@classifier.classify(instance)
		end

		def has_examples?
			@classifier.has_examples?
		end

		def print_probabilities(instance)
			@classifier.print_probabilities(instance)
		end
	end
end