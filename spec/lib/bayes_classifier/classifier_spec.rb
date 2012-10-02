# -*- encoding : utf-8 -*-
require_relative '../../../lib/bayes_classifier/bag_of_words/ngram_model'
require_relative '../../../lib/bayes_classifier/bag_of_words/dictionary'
require_relative '../../../lib/bayes_classifier/probability/simple_probability'
require_relative '../../../lib/bayes_classifier/probability/bayes_classifier'

require_relative '../../../lib/bayes_classifier/classifier'

describe "bayes classifier" do 
	let(:classifier) { BayesClassifier::Classifier.new}

	it "can be trained" do 
		classifier.train("Bar e restaurante Dona Gilda", 'restaurant')
		classifier.train("Massas da Itália", 'restaurant')
		classifier.has_examples?.should be_true
	end
	
	context "with trained data" do 
		before(:each) do 
			classifier.train("Bar e restaurante Dona Gilda", 'restaurant')
			classifier.train("Massas da Itália", 'restaurant')
			classifier.train("Drogaria pacheco", 'drugstore')
			classifier.train("Drogaria Nova", 'drugstore')

		end
		it "classify an instance based on trained data" do 
			# classifier.print_probabilities("Drogaria Mais Barato")

			# classifier.classify("O Bom Galeto Restaurante").should == 'restaurant'
			# classifier.classify("Drogaria Mais Barato").should == 'drugstore'


		end
	end
end