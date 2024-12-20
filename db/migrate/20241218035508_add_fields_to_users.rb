class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :email_address, :string
    add_column :users, :username, :string
    add_column :users, :profile_image, :string
    add_column :users, :birth_date, :date
  end
end
