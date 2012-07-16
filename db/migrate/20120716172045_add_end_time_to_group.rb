class AddEndTimeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :endTime, :integer
  end
end
