class NumberFact
  attr_reader :fact, :subject, :type

  def initialize(json)
    @fact = json["text"]
    @subject = json["number"]
    @type = json["type"]
  end

  def self.fetch
    json = NumberService.new.get_random
    new(json)

  end

end
