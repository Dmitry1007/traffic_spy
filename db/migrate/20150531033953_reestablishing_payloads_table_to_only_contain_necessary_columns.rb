class ReestablishingPayloadsTableToOnlyContainNecessaryColumns < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.text :url
      t.integer :source_id
      t.integer :responded_in
      t.text :resolution
      t.text :browser
      t.text :operating_system
      t.text :requested_at
      t.text :request_type
      t.text :referred_by
      t.text :event_name
      t.integer :sha
    end
  end
end
