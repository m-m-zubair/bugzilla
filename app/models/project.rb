class Project < ApplicationRecord
    has_many :user_project, dependent: :destroy
    has_many :users, through: :user_project
    has_many :bugs, dependent: :destroy
end
