require 'rails_helper'
require 'webmock/rspec'

RSpec.feature 'The Game:', type: :feature do
  before do
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
  end

  describe 'Player visiting for the first time' do
    it 'sees the first question when visiting root' do
      expect(current_path).to eq('/')
      expect(page).to have_content('Trivial Numbers')
      expect(page).to have_content('Score: 0')
      expect(page).to have_content('Guess the Guinness World Record for the most languages a poem was recited in.')
      expect(page).to have_content('146')
    end
  end

  describe 'Player submitting a correct guess' do
    before do
      stub_request(:get, /numbersapi.com/)
      .with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
          })
          .to_return(
            body: '{
            "text": "the number of months in a year",
            "number": 12,
            "found": true,
            "type": "trivia"
            }')
    end

    it "sees a new question and a higher score" do
      choose(option: '146')
      click_button "final answer", disabled: true
      expect(current_path).to eq('/')
      expect(page).to have_content('Score: 100')
      expect(page).to have_content('Guess the number of months in a year.')
      expect(page).to_not have_content('Guess the Guinness World Record for the most languages a poem was recited in.')
    end
  end
end
