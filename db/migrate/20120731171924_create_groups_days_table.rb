class CreateGroupsDaysTable < ActiveRecord::Migration
 def self.up
    create_table :days_groups, :id => false do |t|
        t.references :day
        t.references :group
    end
    add_index :days_groups, [:group_id, :day_id]
    add_index :days_groups, [:day_id, :group_id]
  end

  def self.down
    drop_table :days_groups
  end
end