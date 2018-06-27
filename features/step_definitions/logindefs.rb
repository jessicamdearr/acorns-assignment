Given("email is {string}") do |string|
  @email = string
end

Given("password is {string}") do |string|
  @password = string
end

Given("firstName is {string}") do |string|
  @firstName = string
end

When("the user clicks the login button") do
  visit "http://www.redfin.com"
  click_on "Log In"
  click_on "Continue with Email"
  fill_in "emailInput", :with => @email
    sleep 1 # Some Javascript causing the fill-in to break and with no visible changes on the UI 
    fill_in "passwordInput", :with => @password
    click_on "Sign In"

end

Then("I should be logged in") do
  expect(page).to have_content(@firstName)
end