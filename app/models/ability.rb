# frozen_string_literal: true

# Define the users ability class.
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, Job
    can :create, Application
    return unless user.admin?

    can :manage, Job
    can :read, Application
  end
end
