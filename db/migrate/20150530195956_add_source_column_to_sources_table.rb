class AddSourceColumnToSourcesTable < ActiveRecord::Migration
  def change
    add_column :sources, :source, :text
  end
end
