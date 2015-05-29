class AddUrlRemovePayloadId < ActiveRecord::Migration
  def change
    add_column :payloads, :url_id, :integer
    remove_column :urls, :payload_id
  end
end
