class GameController < ApplicationController
  def new
  end

  def question
    @game = current_game
  end

  def answer
  end
end
