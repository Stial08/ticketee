require 'spec_helper'
feature "Creating Comments" do
  before do
    visit '/'
    state = FactoryGirl.create(:state, :name => "Open")
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project)
    #ticket = FactoryGirl.create(:ticket, project: project.name,title: "Make it Shiny",user: user.id,description: "Holis Holis Holis Holis Holis")
    #ticket.update(user: user)
    visit '/'
    click_link 'Sign In'
    fill_in 'signin_name', with: user.name
    fill_in 'signin_password', with: user.password
    click_button "Sign in"
    visit '/'
    click_link project.name
    click_link "New Ticket" 
    fill_in "Title", with: "Ticket name"
    fill_in "Description", with: "My ticket for the comment"
    click_button "Create Ticket"
  end
  scenario "create a cooment for ticket" do

    fill_in "comment_text",with: "Added one Comment"
    click_button "Create Comment"
    expect(page).to have_content('Added one Comment') 
  end

  scenario "Changing a ticket's state" do
    fill_in "comment_text", :with => "This is a real issue"
    select "Open", :from => "State"
    click_button "Create Comment" 
    page.should have_content("Comment has been created.")
    within("#ticket .state") do
      page.should have_content("Open")
    end
  end
end
