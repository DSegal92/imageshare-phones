class AddCalledOnToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :called_on, :datetime
  end
end
