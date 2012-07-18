class AddMenuLengthToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :menuLength, :integer
  end
end
