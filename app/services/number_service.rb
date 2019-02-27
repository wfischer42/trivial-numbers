class NumberService
  def get_random
    path = "http://numbersapi.com/random/"
    conn = Faraday.new(path)
    response ||= conn.get("trivia?json&fragment&min=0&max=1000000")
    JSON.parse(response.body)
  end
end
