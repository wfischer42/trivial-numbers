class GameController < ApplicationController
  def new
    @game = new_game
    render "question"
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
