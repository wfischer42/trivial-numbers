require 'securerandom'

class Game
  attr_reader :score, :uuid
  def initialize()
    @score = 0
    @uuid = SecureRandom.uuid
    Rails.cache.write(@uuid, self)
  end

  def question
    type = ['trivia', 'date'].sample
    binding.pry
    @question ||= NumberService
  end

  def self.find_or_create(uuid = nil)
    return uncache(uuid) if uuid && uncache(uuid)
    return self.new
  end

  def ==(game)
    @uuid == game.uuid
  end

  def self.uncache(uuid)
    Rails.cache.read(uuid)
  end

  # def hash
  #   @uuid.hash
  # end
end
