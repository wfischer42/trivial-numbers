require 'rails_helper'

RSpec.describe GameController, type: :controller do

  describe "GET #question" do
    it "returns http success" do
      get :question
      expect(session['game_id']).to be_a(String)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #answer" do
    xit "returns http success" do
      get :answer
      expect(response).to have_http_status(:success)
    end
  end

end
