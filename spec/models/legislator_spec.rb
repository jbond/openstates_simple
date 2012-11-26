require 'spec_helper'

describe Legislator do

  describe 'load' do

    let(:filecontents1) do
      "leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,created_at,updated_at\n" +
      "IAL000999,Mickey Mouse,Mickey,,Mouse,,,True,ia,lower,99,Democrat,80acdce8cf8b4e999209b87648e58999,http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=999,2011-09-13 01:16:51.017000,2012-10-29 04:04:00.094000\n" +
      "IAL000888,Donald Duck,Donald,,Duck,,,True,ia,lower,88,Republican,80acdce8cf8b4e988809b87648e58889,http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=888,2011-09-13 01:16:51.017000,2012-10-29 04:04:00.094000\n"
    end
    let(:expected_leg1) do
      {
      	"full_name" => "Mickey Mouse", "first_name" => "Mickey", "middle_name" => nil, "last_name" => "Mouse",
        "suffixes" => nil, "active" => true, "state" => "ia", "chamber" => "lower", "district" => 99,
        "party" => "Democrat", "photo_url" => "http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=999"
      }
    end
    let(:expected_leg2) do
      {
      	"full_name" => "Donald Duck", "first_name" => "Donald", "middle_name" => nil, "last_name" => "Duck",
        "suffixes" => nil, "active" => true, "state" => "ia", "chamber" => "lower", "district" => 88,
        "party" => "Republican", "photo_url" => "http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=888"
      }
    end
    let(:filecontents2) do
      "leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,created_at,updated_at\n" +
      "IAL000888,Donald Duck,Donald,,Duck,,,False,ia,,,,80acdce8cf8b4e988809b87648e58889,http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=888,2011-09-13 01:16:51.017000,2012-10-29 04:04:00.094000\n" +
      "IAL000777,Pluto T. Dog Jr.,Pluto,The,Dog,Jr.,,True,ia,lower,77,Democrat,80acdce8cf8b47779209b87648777999,http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=777,2011-09-13 01:16:51.017000,2012-10-29 04:04:00.094000\n"
    end
    let(:expected_leg2b) do
      {
      	"full_name" => "Donald Duck", "first_name" => "Donald", "middle_name" => nil, "last_name" => "Duck",
        "suffixes" => nil, "active" => false, "state" => "ia", "chamber" => nil, "district" => nil,
        "party" => nil, "photo_url" => "http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=888"
      }
    end
    let(:expected_leg3) do
      {
      	"full_name" => "Pluto T. Dog Jr.", "first_name" => "Pluto", "middle_name" => "The", "last_name" => "Dog",
        "suffixes" => "Jr.", "active" => true, "state" => "ia", "chamber" => "lower", "district" => 77,
        "party" => "Democrat", "photo_url" => "http://www.legis.iowa.gov/getPhotoPeople.aspx?GA=84&PID=777"
      }
    end


    it "should parse and load legislators from a csv file" do
      File.stub(:open).with("data.csv", "rb") { StringIO.new(filecontents1) }
      Legislator.load "data.csv"
      Legislator.all.should have(2).items
      (Legislator.find_by_leg_id! "IAL000999").attributes.should include(expected_leg1)
      (Legislator.find_by_leg_id! "IAL000888").attributes.should include(expected_leg2)
    end

    it "should add new legislators and update existing ones when re-loading" do
      File.stub(:open).with("data.csv", "rb") { StringIO.new(filecontents1) }
      Legislator.load "data.csv"
      File.stub(:open).with("data.csv", "rb") { StringIO.new(filecontents2) }
      Legislator.load "data.csv"
      Legislator.all.should have(3).items
      (Legislator.find_by_leg_id! "IAL000999").attributes.should include(expected_leg1)
      (Legislator.find_by_leg_id! "IAL000888").attributes.should include(expected_leg2b)
      (Legislator.find_by_leg_id! "IAL000777").attributes.should include(expected_leg3)
    end

  end

end
