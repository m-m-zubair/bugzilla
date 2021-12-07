class ChangeDataTypeForStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :bugs, :status, :string
  end
end
