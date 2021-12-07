class ChangeDataTypeForBugType < ActiveRecord::Migration[6.1]
  def change
    change_column :bugs, :bug_type, :string
  end
end
