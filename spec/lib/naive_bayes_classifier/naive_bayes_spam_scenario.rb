require_relative '../../../lib/naive_bayes_classifier/bag_of_words/ngram_model'
require_relative '../../../lib/naive_bayes_classifier/bag_of_words/vocabulary'
require_relative '../../../lib/naive_bayes_classifier/probability/probability_model'
require_relative '../../../lib/naive_bayes_classifier/bayes_rule'
require_relative '../../../lib/naive_bayes_classifier/classifier'

describe "Naive Bayes Classifier" do 
	let(:classifier) {NaiveBayesClassifier::Classifier.new}

	context "about a spam classifier" do 
		before(:each) do 
			classifier.train("offer is secret", :spam)
			classifier.train("click secret link", :spam)
			classifier.train("secret sports link", :spam)

			classifier.train("play sports today", :ham)
			classifier.train("went play sports",:ham)
			classifier.train("secret sports event",:ham)
			classifier.train("sports is today",:ham)
			classifier.train("sports cost money",:ham)
		
			@vocabulary  	= NaiveBayesClassifier::BagOfWords::Vocabulary.new(classifier.examples)
			@probability 	= NaiveBayesClassifier::Probability::ProbabilityModel.new(@vocabulary)
			@bayes_rule   = NaiveBayesClassifier::BayesRule.new(classifier.examples)

		end

		describe "about the probabilty model" do 

			it "should calculate the probability of the word 'sports' be spam" do 
				@bayes_rule.bayes_rule("sports", :spam).should be_within(0.02).of(0.2)
			end

			it "should calculate the probability of the message 'secret is secret' be spam" do 
				@bayes_rule.bayes_rule("secret is secret", :spam).should be_within(0.02).of(0.902)
			end

			# it  "shoudl calculate the probability of anything be spam" do 
			# 	@probability.prior(:spam).should be_within(0.02).of(0.384)
			# end

			# it  "shoudl calculate the probability of anything be ham" do 
			# 	@probability.prior(:ham).should be_within(0.02).of(0.615)
			# end

			it "should calculate the probability of the message 'today is secret' be spam" do 
				@bayes_rule.bayes_rule("today is secret", :spam).should be_within(0.02).of(0)
			end



			it "should calculate the probability of the message 'today' be spam" do 
				@bayes_rule.bayes_rule("today", :spam).should be_within(0.02).of(0)
			end




		end

	end



end
