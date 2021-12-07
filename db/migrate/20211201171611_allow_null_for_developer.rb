class AllowNullForDeveloper < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bugs, :developer_user_id, true
  end
end
