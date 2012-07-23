class AddAliasToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :alias, :string
  end
end
