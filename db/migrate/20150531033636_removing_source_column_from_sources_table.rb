class RemovingSourceColumnFromSourcesTable < ActiveRecord::Migration
  def change
    remove_column :sources, :source
  end
end
