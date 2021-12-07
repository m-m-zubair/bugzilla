class CreateBugs < ActiveRecord::Migration[6.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.datetime :deadline
      t.integer :bug_type
      t.integer :status
      t.references :creator_user, null: false, foreign_key: { to_table: :users }
      t.references :developer_user, null: false, foreign_key: { to_table: :users }
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
