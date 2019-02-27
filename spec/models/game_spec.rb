require 'rails_helper'
require 'securerandom'

RSpec.describe Game do
  let(:game) { Game.new() }

  # TODO: Reorganize tests into method descriptions
  it 'exists' do
    expect(game).to be_a(Game)
  end

  it 'has a default score' do
    expect(game.score).to eq(0)
  end

  it 'has a UUID' do
    expect(game.uuid).to be_a(String)
  end

  it 'is cached on creation' do
    cached_game = Rails.cache.read(game.uuid)
    expect(cached_game).to eq(game)
  end

  it 'can be pulled from cache with the UUID' do
    uncached = Game.uncache(game.uuid)
    expect(uncached).to eq(game)
  end

  context "instance methods" do
    let(:number_fact) do
      double("NumberFact", fact: "the number of months in a year", subject: 12)
    end

    describe "question" do
      it "returns a question" do
        expect(NumberFact).to receive(:fetch).and_return(number_fact)
        allow(Rails.cache).to receive(:write)
        question = game.question
        expect(number_fact).to have_received(:fact)
        expect(question).to eq("Guess the number of months in a year.")
      end
    end

    describe "choices" do
      it "returns a set of 4 choices" do
        expect(NumberFact).to receive(:fetch).and_return(number_fact)
        allow(Rails.cache).to receive(:write)
        choices = game.choices
        expect(number_fact).to have_received(:subject)
        expect(choices).to include(12)
        expect(choices.length).to eq(4)
      end
    end

    describe "register_guess" do
      before do
        allow(NumberFact).to receive(:fetch).and_return(number_fact)
        allow(Rails.cache).to receive(:write)
        game.new_number_fact
      end

      it "increments score for a correct guess" do
        game.register_guess(12)
        expect(game.score).to eq(100)
      end

      it "decrements score for an incorrect guess" do
        game.register_guess(11)
        expect(game.score).to eq(-50)
      end

      it "resets the question" do
        expect(NumberFact).to receive(:fetch).and_return(number_fact)
        game.register_guess(12)
      end
    end
  end

  context "class methods" do
    describe '.find_or_create(uuid)' do
      it 'creates new game for nil input' do
        new_game = Game.find_or_create(nil)
        expect(new_game).to be_a(Game)
        expect(new_game).to_not eq(game)
      end

      it 'creates new game for no input' do
        new_game = Game.find_or_create
        expect(new_game).to be_a(Game)
        expect(new_game).to_not eq(game)
      end

      it 'creates a new game for invalid uuid' do
        new_game = Game.find_or_create(SecureRandom.uuid)
        expect(new_game).to be_a(Game)
        expect(new_game).to_not eq(game)
      end

      it 'retrieves cached game for valid uuid' do
        new_game = Game.find_or_create(game.uuid)
        expect(new_game).to eq(game)
      end
    end
  end
end
