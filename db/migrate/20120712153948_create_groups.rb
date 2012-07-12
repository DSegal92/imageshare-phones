class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :identity
      t.integer :phone_id
      t.integer :extension
      t.string :email

      t.timestamps
    end
  end
end
