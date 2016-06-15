require 'rails_helper'

RSpec.describe "items/index", :type => :view do
  describe "GET /items" do
    it "reaches the root page" do

      visit '/'

      expect(page.status_code).to eq(200)

      within('h1') do
        expect(page).to have_content?('Items'), "page should have an Items heading"
      end
    end
  end

end