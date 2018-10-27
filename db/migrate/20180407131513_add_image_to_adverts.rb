class AddImageToAdverts < ActiveRecord::Migration[5.1]
  def change
    add_column :adverts, :image, :string
  end
end
