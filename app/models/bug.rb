class Bug < ApplicationRecord
  validates :title,:status,:bug_type, presence: true
  validates :title, uniqueness: { scope: :project_id,
        message: "This Bug already created" }

  belongs_to :creator_user, class_name: 'User'
  belongs_to :developer_user, class_name: 'User', optional: true
  belongs_to :project
  mount_uploader :image, ImageUploader
end
