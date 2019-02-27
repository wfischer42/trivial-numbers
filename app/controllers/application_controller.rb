class ApplicationController < ActionController::Base
  helper_method :current_game
  def current_game
    @current_game ||= Game.find_or_create(session['game_id'])
    session['game_id'] = @current_game.uuid
    return @current_game
  end
end
