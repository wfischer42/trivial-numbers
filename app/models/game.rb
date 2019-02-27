require 'securerandom'

class Game
  attr_reader :score, :uuid, :number_fact
  def initialize()
    @score = 0
    @uuid = SecureRandom.uuid
    @number_fact ||=  NumberFact.fetch
    Rails.cache.fetch(@uuid){ self }
  end

  def question
    @number_fact || new_number_fact
    question = "Guess " + @number_fact.fact + "."
  end

  def choices(number = 4)
    @number_fact || new_number_fact
    answer = @number_fact.subject
    range = ((answer * 0.25)..((answer + 10) * 1.75))
    choices = [answer]
    while choices.length < number do
      choice = rand(range).round
      choices << choice unless choices.include?(choice)
    end
    choices.shuffle
  end

  def new_number_fact
    @number_fact = NumberFact.fetch
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
