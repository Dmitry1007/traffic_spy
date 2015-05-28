class DeleteClientsTable < ActiveRecord::Migration
  def change
    drop_table :clients
  end
end
