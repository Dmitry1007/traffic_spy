class CreateRespondedInTable < ActiveRecord::Migration
  def change
    create_table :responded_ins do |t|
      t.integer :responded_in

      t.timestamps
    end
  end
end
