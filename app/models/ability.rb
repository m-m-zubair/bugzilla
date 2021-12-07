# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)    
    if user.present?
      case user.user_type
        when "manager"
          can :manage , [Project,Bug]
        when "developer"
          can [:read], Project
          can :manage, Bug
        when "qa"
          can :read, Project
          can :manage, Bug
        end
      end
    else
      can :read, [Project,Bug]
  end
end






