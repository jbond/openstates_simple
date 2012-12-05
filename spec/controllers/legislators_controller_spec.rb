require 'spec_helper'

describe LegislatorsController do

  describe "#lookup" do
    it "gets the legislator record from the model" do
      Legislator.should_receive(:lookup).with("IAL000555")
      get :lookup, {:leg_id => "IAL000555"}
    end

    it "returns json representation of legislator, if found" do
      leg = Legislator.new
      Legislator.stub(:lookup).and_return leg
      get :lookup, {:leg_id => "IAL000555", :format => :json}
      response.should be_ok
      response.header['Content-Type'].should include 'application/json'
    end

    it "returns json error message, if legislator not found" do
      Legislator.stub(:lookup).and_return nil
      get :lookup, {:leg_id => "IAL000555", :format => :json}
      response.should be_not_found
      response.header['Content-Type'].should include 'application/json'
      ActiveSupport::JSON.decode(response.body).
        should include({"error"=>"Legislator ID IAL000555 not found"})
    end
  end

end

