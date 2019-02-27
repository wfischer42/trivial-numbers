class GameController < ApplicationController
  def new
  end

  def question
    @game = current_game
  end

  def answer
    @game = current_game
  end

  private
  def choice
    params.require("choice")
  end
end
