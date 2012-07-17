class AddEnableToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :enable, :boolean
  end
end
