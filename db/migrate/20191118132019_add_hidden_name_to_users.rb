class AddHiddenNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hidden_name, :string
  end
end
