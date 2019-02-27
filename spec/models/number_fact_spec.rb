require 'rails_helper'
require 'securerandom'

RSpec.describe NumberFact do
  let!(:json) do
    {
      "text": "the number of NFL regular season football games",
      "number": 256,
      "found": true,
      "type": "trivia"
    }
  end
  let(:number_fact) { NumberFact.new(json) }

  describe "Attributes:" do
    it "has a fact" do
      expect(number_fact.fact).to eq(json["text"])
    end
    it "has a subject" do
      expect(number_fact.subject).to eq(json["number"])
    end
    it "has a type" do
      expect(number_fact.type).to eq(json["type"])
    end
  end

  context "Instance Methods" do

  end

  context "Class Methods" do
    describe "#fetch" do
      it "initalizes a new NumberFact using the service" do
        allow_any_instance_of(NumberService).to receive(:get_random).and_return(json)
        new_number_fact = NumberFact.fetch
        expect(new_number_fact).to be_a(NumberFact)
        expect(new_number_fact.fact).to eq(json["text"])
      end
    end
  end
end
