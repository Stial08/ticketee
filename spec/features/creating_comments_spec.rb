require 'spec_helper'
feature "Creating Comments" do
  before do
    visit '/'
    state = FactoryGirl.create(:state, :name => "Open")
    project = FactoryGirl.create(:project)
    loguin
    click_link project.name
    create_ticket
  end
  scenario "create a cooment for ticket" do

    fill_in "comment_text",with: "Added one Comment"
    click_button "Create Comment"
    expect(page).to have_content('Added one Comment') 
  end

  scenario "Can't create a comment without text" do
    select "Open", :from => "State"
    click_button "Create Comment" 
    page.should have_content("Comment has not been created.")
  end
end
