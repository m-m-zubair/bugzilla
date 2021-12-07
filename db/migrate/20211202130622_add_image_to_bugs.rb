class AddImageToBugs < ActiveRecord::Migration[6.1]
  def change
    add_column :bugs, :image, :string
  end
end
