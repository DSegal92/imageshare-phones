class AddLengthToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :length, :string
  end
end
