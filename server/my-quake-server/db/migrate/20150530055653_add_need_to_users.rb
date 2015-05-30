class AddNeedToUsers < ActiveRecord::Migration
  def change
  	add_column :users,:need,:string
  end
end
