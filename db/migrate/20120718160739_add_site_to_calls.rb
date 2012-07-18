class AddSiteToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :site, :string
  end
end
