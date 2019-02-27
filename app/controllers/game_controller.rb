class GameController < ApplicationController
  def new
  end

  def question
    @game = current_game
  end

  def answer
    @game = current_game
    @game.register_guess(choice)
    render "question"
  end

  private
  def choice
    params.require("choice")
  end
end
