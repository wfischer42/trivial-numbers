require 'rails_helper'

RSpec.feature 'Player', type: :feature do
  context 'visiting for the first time' do
    it 'sees the first question when visiting root' do
      visit '/'
      expect(current_path).to eq('/')
      expect(page).to have_content('Trivial Numbers')
      expect(page).to have_content('Score: 0')
      expect(page).to have_content('What is the number of')
    end
  end
end
