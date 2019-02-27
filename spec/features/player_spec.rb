require 'rails_helper'
require 'webmock/rspec'

RSpec.feature 'Player', type: :feature do
  context 'visiting for the first time' do
    it 'sees the first question when visiting root' do
      stub_request(:get, /numbersapi.com/)
        .with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v0.15.4'
          })
        .to_return(
          body: '{
            "text": "the Guinness World Record for the most languages a poem was recited in",
            "number": 146,
            "found": true,
            "type": "trivia"
          }')

      visit '/'
      expect(current_path).to eq('/')
      expect(page).to have_content('Trivial Numbers')
      expect(page).to have_content('Score: 0')
      expect(page).to have_content('Guess the Guinness World Record for the most languages a poem was recited in.')
      expect(page).to have_content('146')
    end
  end
end
