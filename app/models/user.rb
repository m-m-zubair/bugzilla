class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type:{
    developer:0, 
    manager:1, 
    qa:2
  }
  has_many :user_project
  has_many :projects, through: :user_project

  has_many :creator_user_bugs, class_name: 'Bug', foreign_key: 'creator_user_id'
  has_many :developer_user_bugs, class_name: 'Bug', foreign_key: 'developer_user_id'
end
