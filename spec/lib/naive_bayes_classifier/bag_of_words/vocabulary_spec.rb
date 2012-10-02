require_relative '../../../../lib/naive_bayes_classifier/bag_of_words/ngram_model'
require_relative '../../../../lib/naive_bayes_classifier/bag_of_words/vocabulary'


describe "vocabulary" do 
	before(:each) do
		@examples = {:restaurant => ["O dom Galeto", "Zagatti Bar e restaurante", "Pizza Grill Bar e Pizzaria"],
								 :drugstore => ["Drogaria Pacheco", "DrogaMais farmacia"]}
	end
	let(:vocabulary) {NaiveBayesClassifier::BagOfWords::Vocabulary.new(@examples)}

	it "should have a vocabulary of terms used in the training set" do 
		vocabulary.data.should_not be_empty
	end

	it "should allow access the terms by label" do 
		vocabulary.data[:restaurant].should_not be_empty
		vocabulary.data[:restaurant].keys.should include("galeto")
		vocabulary.data[:drugstore].keys.should include("farmacia")
	end

	it "should be possible to know the frequence of terms" do 
		vocabulary.data[:restaurant]["galeto"].should == 1
		vocabulary.data[:restaurant]["bar"].should == 2
	end

	it "should be possible to verify if an specific class exists" do 
		vocabulary.include?(:restaurant).should be_true
	end

	it "should be possible to get the count of words for an specific class" do 
		vocabulary.words_count_of(:restaurant).should == 12
	end

	it "should be possible to get the total count of words in vocabulary" do 
		vocabulary.number_of_words.should == 16
	end

	it "should return the words in a sentence" do 
		words = vocabulary.words("Bar e Restaurante")
		words.should include("bar")
		words.should include("e")
		words.should include("restaurante")
	end

	it "should return the word counts of a specific class" do 
		vocabulary.count_of("bar", :restaurant).should == 2
	end

end
