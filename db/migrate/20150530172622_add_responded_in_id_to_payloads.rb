class AddRespondedInIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :responded_in_id, :integer
  end
end
