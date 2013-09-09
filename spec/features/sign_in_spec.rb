require 'spec_helper'
feature "signing in." do
  scenario 'Signing in via form' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Sign in'
    fill_in 'signin_name', with: user.name
    fill_in 'signin_password', with: user.password
    click_button "Sign in"
    expect(page).to have_content("Signed in successfully.")
  end
end
