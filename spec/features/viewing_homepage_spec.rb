require 'rails_helper'

feature 'viewing the homepage' do
  scenario 'user sees the welcome text' do
    visit root_path
    welcome_text = 'Go to tenmoves.net for the real thing'
    expect(page).to have_content welcome_text
  end
end
