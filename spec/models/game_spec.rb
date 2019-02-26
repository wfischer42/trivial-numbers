require 'rails_helper'
require 'securerandom'

RSpec.describe Game do
  let(:game) { Game.new() }

  # TODO: Reorganize tests
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

  context "Class methods" do
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
