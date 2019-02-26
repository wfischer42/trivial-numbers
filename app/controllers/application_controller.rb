class ApplicationController < ActionController::Base
  helper_method :current_game
  def current_game
    @game ||= Game.find_or_create(session['game_id'])
    session['game_id'] = @game.uuid
    return @game
  end
end
