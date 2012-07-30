class AddCallbackToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :callback, :integer
  end
end
