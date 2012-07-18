class AddMenuTimeToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :menuTime, :string
  end
end
