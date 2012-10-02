module NaiveBayesClassifier
	class Classifier
		attr_reader :examples
		
		def initialize(examples = {})
		 	@examples = examples			
		end

		def train(example, label)
			@examples[label] = [] if @examples[label].nil?
			@examples[label] << example
		end

		def classify(instance, bayes_rule = BayesRule.new(@examples))
			probabilities = bayes_rule.calculate(instance)
			return :nothing if probabilities.nil? || probabilities.empty?
			probabilities.max {|a,b| a.last <=> b.last}.first
		end
	end
end