class AddUserAgentToUserAgentTable < ActiveRecord::Migration
  def change
    add_column :user_agents, :user_agent, :text
  end
end
