require_relative '../../../../lib/naive_bayes_classifier/probability/probability_model'

describe "Probability Model" do 
	before(:each) do 
		@examples = {:restaurant => ["O dom Galeto", "Zagatti Bar e restaurante", "Pizza Grill Bar e Pizzaria"],
								 :drugstore => ["Drogaria Pacheco", "DrogaMais farmacia"]}
    @vocabulary = double()
		@probability_model = NaiveBayesClassifier::Probability::ProbabilityModel.new(@vocabulary)
	end

	
	it "should be possible to calculate the prior probability" do 
    @vocabulary.should_receive(:include?).with(:restaurant).and_return(true)
    @vocabulary.should_receive(:words_count_of).with(:restaurant).and_return(12)
    @vocabulary.should_receive(:number_of_words).and_return(15)

		@probability_model.prior(:restaurant).should be_within(0.02).of(0.80)
	end

	it "should be possible to calculate the conditional probability" do 
    @vocabulary.should_receive(:words_count_of).with(:restaurant).and_return(12,12,12)
		@vocabulary.should_receive(:count_of).and_return(2, 2, 1)
		@vocabulary.should_receive(:words).and_return(["bar", "e", "restaurante"])
		@probability_model.conditional("Bar e restaurante", :restaurant).should be_within(0.2).of(0.00)
	end

end
