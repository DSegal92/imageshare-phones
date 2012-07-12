class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :identity
      t.string :number
      t.integer :extension

      t.timestamps
    end
  end
end
