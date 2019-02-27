require 'securerandom'

class Game
  attr_reader :score, :uuid, :number_fact
  def initialize()
    @score = 0
    @uuid = SecureRandom.uuid
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

  def register_guess(guess)
    increase_score if guess.to_i == @number_fact.subject
    decrease_score if guess.to_i != @number_fact.subject
    new_number_fact
  end

  def new_number_fact
    @number_fact = NumberFact.fetch
    Rails.cache.write(@uuid, self)
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

  private

    def increase_score
      @score += 100
    end

    def decrease_score
      @score -= 50
    end

  # def hash
  #   @uuid.hash
  # end
end
