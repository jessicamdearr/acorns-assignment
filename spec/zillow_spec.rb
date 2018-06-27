require 'spec_helper'
describe "zillow test", :type => :request do

  it "searches for a particular property and verfies the response status" do
    conn = Faraday.new(:url => 'https://www.zillow.com/') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
    
    # 1 - search for property
    response = conn.get do |req|
      req.url '/webservice/GetSearchResults.htm', "zws-id" => ENV.fetch('ZILLOW_API_KEY')
      req.params['address'] = "12371 Zig Zag Way"
      req.params['citystatezip'] = "92780"
    end

    # 2 - verify response status
    expect(response.success?).to be true

    # 3 - verify response body
    doc = Nokogiri::XML(response.body)
    address = doc.at_xpath('//response//address')
    expect(address.at_xpath('//street').content.upcase).to eq "12371 ZIG ZAG WAY"
    expect(address.at_xpath('//zipcode').content).to eq "92780"
    expect(address.at_xpath('//city').content.upcase).to eq "TUSTIN"
    expect(address.at_xpath('//state').content.upcase).to eq "CA"
  end
end