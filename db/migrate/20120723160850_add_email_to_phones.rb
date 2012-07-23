class AddEmailToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :email, :string
  end
end
