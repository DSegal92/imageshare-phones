class CreateAnsweredCalls < ActiveRecord::Migration
  def change
    create_table :answered_calls do |t|
      t.string :identity
      t.boolean :was_target
      t.string :elapsed
      t.integer :call_id
      t.integer :phone_id

      t.timestamps
    end
  end
end
