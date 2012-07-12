class CreateGroupsPhonesTable < ActiveRecord::Migration
 def self.up
    create_table :groups_phones, :id => false do |t|
        t.references :group
        t.references :phone
    end
    add_index :groups_phones, [:group_id, :phone_id]
    add_index :groups_phones, [:phone_id, :group_id]
  end

  def self.down
    drop_table :groups_phones
  end
end