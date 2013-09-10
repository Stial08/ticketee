require 'spec_helper'
before do
  user = FactoryGirl.create(:user)
  project = FacrotyGirl.create(:project)
  ticket = Factory.Girl.create(:ticket, project: project.name,title: "Make it Shiny",user: user.id,description: "Holis Holis Holis Holis Holis")
  ticket.update(user: user)
  visit '/'
  click_link 'Sign In'
  fill_in 'signin_name', with: user.name
  fill_in 'signin_password', with: user.password
  click_button "Sign in"
  visit '/'
  click_link project.name
  click_link ticket.name 
end
feature "Creating comments" do
  click_link "New Comment"
  fill_in "text",with: "Added one Comment"
  click_button "Create Comment"
  expect(page).to have_content('') 
end
