class AddAdvertIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :advert_id, :integer
  end
end
