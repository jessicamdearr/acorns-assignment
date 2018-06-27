Given("zip is {string}") do |string|
  @zip = string
end

Given("minimum_beds is {string}") do |string|
  @minimum_beds = string
end

Given("maximum_beds is {string}") do |string|
  @maximum_beds = string
end

Given("minimum_sqft is {string}") do |string|
  @minimum_sqft = string
end

Given("minimum_price is {string}") do |string|
  @minimum_price = string
end

Given("minimum_price_numerical is {string}") do |string|
  @minimum_price_numerical = string.to_f
end

When("the user clicks the search button") do
  Capybara.current_session.current_window.resize_to(2000,8000)
  visit "http://www.redfin.com"
  within("#homepageTabContainer") do
    fill_in "searchInputBox", :with => @zip
    click_on "Search"
  end
end

Then("I should be able to filter and get results") do
  find(:xpath, '//div[@id="wideSidepaneFilterButtonContainer"]/button').click
end

When("the user chooses a price filter") do
  find(:css, 'span.minPrice').click
  find(:xpath, "//span[contains(@class, 'minPrice')]//div[contains(@class, 'option')]/span[. = '#{@minimum_price}']").click
end

When("the user chooses a bedroom filter") do
  find(:css, 'span.minBeds').click
  find(:xpath, "//span[contains(@class, 'minBeds')]//div[contains(@class, 'option')]/span[contains(., '#{@minimum_beds}')]").click
  find(:css, 'span.maxBeds').click
  find(:xpath, "//span[contains(@class, 'maxBeds')]//div[contains(@class, 'option')]/span[contains(., '#{@maximum_beds}')]").click
end

When("the user chooses a sqft filter") do
  find(:css, 'span.sqftMin').click
  find(:xpath, "//span[contains(@class, 'sqftMin')]//div[contains(@class, 'option')]/span[. = '#{@minimum_sqft}']").click
end

When("the user clicks the Apply Filters button") do
  click_on "Apply Filters"
  find(:xpath, "//button/span[contains(., 'Table')]/ancestor::button").click
  expect(page).to have_css('#tableView-table-header')

end

Then("the results should have the proper price") do
  price_elements = page.all(:xpath, "//tr/td[contains(@class, 'col_price')]")
  expect(price_elements.size).to be > 0
  price_elements.each do |price|
    price_count = price.text.gsub(/[^0-9\.]/, "").to_f
    expect(price_count).to be >= @minimum_price_numerical
  end
end

Then("the results should have the proper number of bedrooms") do
  bed_elements = page.all(:xpath, "//tr/td[contains(@class, 'col_beds')]")
  expect(bed_elements.size).to be > 0
  bed_elements.each do |beds|
    bed_count = beds.text.to_f
    expect(bed_count).to be >= @minimum_beds.to_f
    expect(bed_count).to be <= @maximum_beds.to_f
  end
end

Then("the results should have the proper sqft") do
  sqft_elements = page.all(:xpath, "//tr/td[contains(@class, 'col_sqft')]")
  expect(sqft_elements.size).to be > 0
  sqft_elements.each do |sqft|
    sqft_count = sqft.text.gsub(/[^0-9\.]/, "").to_f
    expect(sqft_count).to be >= @minimum_sqft.gsub(/[^0-9\.]/, "").to_f
  end
end