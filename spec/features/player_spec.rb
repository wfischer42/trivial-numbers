require 'rails_helper'

RSpec.feature 'Player', type: :feature do
  context 'visiting for the first time' do
    it 'sees the first question when visiting root' do
      # number_fact = double("NumberFact", subject: 12, fact: "the number of months in a year")
      # allow(NumberFact).to receive(:new).and_return(number_fact)

      visit '/'
      expect(current_path).to eq('/')
      expect(page).to have_content('Trivial Numbers')
      expect(page).to have_content('Score: 0')
      expect(page).to have_content('The number of months in a year:')
      expect(page).to have_content('12')
    end
  end
end
