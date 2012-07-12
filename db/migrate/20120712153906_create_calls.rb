class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :target
      t.string :origin
      t.string :length
      t.integer :times_called
      t.boolean :was_connected
      t.string :caller_ID
      t.string :location
      t.text :notes
      t.integer :answered_id

      t.timestamps
    end
  end
end
