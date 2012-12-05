class Legislator < ActiveRecord::Base
  attr_accessible :active, :chamber, :district, :first_name, :full_name, :last_name, :leg_id, :middle_name,
    :nickname, :party, :photo_url, :state, :suffixes

  def self.lookup(leg_id)
    Legislator.find_by_leg_id(leg_id)
  end

  def as_json(options={})
    super(:only => [:leg_id, :full_name, :first_name, :middle_name, :last_name, :suffixes, :state,
      :active, :chamber, :district, :party, :photo_url])
  end

  def self.load filepath
    require 'csv'
    CSV.foreach(filepath, :headers => true) do |row|
      legislator = find_or_initialize_by_leg_id(row[0])
      legislator.update_attributes(
        :leg_id => row[0],
        :full_name => row[1],
        :first_name => row[2],
        :middle_name => row[3],
        :last_name => row[4],
        :suffixes => row[5],
        :active => (row[7] == "True"),
        :state => row[8],
        :chamber => row[9],
        :district => row[10],
        :party => row[11],
        :photo_url => row[13]
      )
    end
  end

end
