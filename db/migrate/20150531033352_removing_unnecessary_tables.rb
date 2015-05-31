class RemovingUnnecessaryTables < ActiveRecord::Migration
  def change
    drop_table :responded_ins
    drop_table :urls
    drop_table :user_agents
  end
end
