require 'rails_helper'

feature 'viewing dashboard' do
  scenario 'user sees number of moves' do
    create :move
    authenticate
    visit admin_path

    within ".stats" do
      expect(page).to have_content Move.count
    end
  end

  scenario 'user sees the top list of moves' do
    11.times { |i| create :move, name: "move ##{i}" }

    authenticate
    visit admin_path

    within ".top-list" do
      1.upto(10) do |i|
        expect(page).to have_css "li", text: "move ##{i}"
      end
    end
  end

  scenario "user sees how many of each move there is" do
    3.times do
      create :move, name: "Sybil"
    end
    authenticate
    visit admin_path

    expect(page).to have_content "Sybil (3)"
  end

  def authenticate
    page.driver.browser.authorize(ENV['admin_username'], ENV['admin_password'])
  end
end
