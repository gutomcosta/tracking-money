require_relative '../../../lib/naive_bayes_classifier/bayes_rule'
require_relative '../../../lib/naive_bayes_classifier/classifier'

describe "Naive Bayes Classifier" do 
	let(:classifier) {NaiveBayesClassifier::Classifier.new}


	context "about training classifier" do 
		it "should be possible to train the classifier" do 
			classifier.train("O Bom Galeto", :restaurant)
			classifier.train("Zagatti bar e restaurante", :restaurant)
			classifier.train("Banco Itau SA", :bank)

			classifier.examples.should_not be_empty
			classifier.examples.include?(:restaurant).should be_true
			classifier.examples.include?(:bank).should be_true
		end

		it "save the complete example in the training process" do 
			classifier.train("O Bom Galeto", :restaurant)
			classifier.examples[:restaurant].should include("O Bom Galeto")
		end
	end

	context "about the classification" do 
		before(:each) do 
			classifier.train("O Bom Galeto", :restaurant)
			classifier.train("Zagatti bar e restaurante", :restaurant)
			classifier.train("Drogarias Pacheco", :drugstore)
			classifier.train("Mediciamenta Farmacia de manipulacao", :drugstore)
			classifier.train("DrogaMil drograria", :drugstore)
			classifier.train("banco Santander", :bank)
			classifier.train("banco Itau SA", :bank)
			classifier.train("banco do Brasil", :bank)
		end

		it "should classify as restaurant the example 'Restaurante Pizza Mais'" do 
			bayes_rule = double()
			bayes_rule.stub(:calculate).and_return({:restaurant => 0.77, :drugstore => 0.22, :bank => 0.012})
			classifier.classify("Restaurante Pizza Mais", bayes_rule).should == :restaurant
		end

		it "should classify as drugstore the example 'DrogaMais farmacia'" do 
			bayes_rule = double()
			bayes_rule.stub(:calculate).and_return({:restaurant => 0.22, :drugstore => 0.88, :bank => 0.012})
			classifier.classify("DrogaMais farmacia", bayes_rule).should == :drugstore
		end

	end
end