class AddUserIdToAdverts < ActiveRecord::Migration[5.1]
  def change
  	add_column :adverts, :user_id, :integer
  end
end
