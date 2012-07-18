class AddAnsweredToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :answered, :string
  end
end
