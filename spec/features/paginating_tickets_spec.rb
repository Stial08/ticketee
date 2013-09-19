require 'spec_helper'
feature 'Paginating tickets' do
  project = FactoryGirl.create(:project)
  before do
    loguin 
    @default_per_page = Kaminari.config.default_per_page
    Kaminari.config.default_per_page = 1
    3.times do |i|
      ticket = project.tickets.new
      ticket.title = "Test"
      ticket.description = "Placeholder ticket."
      ticket.user = @user
      ticket.save
    end
    visit root_path
    click_link project.name
  end
  after do
    Kaminari.config.default_per_page = @default_per_page
  end

  it "displays pagination" do
    all(".pagination .page").count.should == 3
    within(".pagination .next") do
      click_link "Next"
    end
    current_page = find("*.pagination .current").text.strip
    current_page.should == "2"
  end
end
