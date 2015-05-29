class DropUrlColumnFromPayloadsTable < ActiveRecord::Migration
  def change
    remove_column :payloads, :url
  end
end
