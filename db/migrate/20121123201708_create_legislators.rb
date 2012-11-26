class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :leg_id
      t.string :full_name
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffixes
      t.boolean :active
      t.string :state
      t.string :chamber
      t.integer :district
      t.string :party
      t.string :photo_url
 
      t.timestamps
    end
  end
end
