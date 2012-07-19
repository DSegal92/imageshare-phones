class AddSessionToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :session, :string
  end
end
