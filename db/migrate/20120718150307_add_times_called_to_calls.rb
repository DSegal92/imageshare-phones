class AddTimesCalledToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :timesCalled, :integer
  end
end
