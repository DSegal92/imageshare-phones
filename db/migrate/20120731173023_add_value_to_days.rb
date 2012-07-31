class AddValueToDays < ActiveRecord::Migration
  def change
    add_column :days, :value, :integer
  end
end
