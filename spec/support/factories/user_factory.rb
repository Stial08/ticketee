FactoryGirl.define do
  factory :user do
    email "sample@example.com"
    password "hunter12345"
    password_confirmation "hunter12345"
    admin false
  end
end
