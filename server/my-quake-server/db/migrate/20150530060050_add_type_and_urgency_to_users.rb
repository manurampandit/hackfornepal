class AddTypeAndUrgencyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :utype, :integer
  	add_column :users, :urgency, :string
  	add_column :users, :disaster, :string
  end
end
