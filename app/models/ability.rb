class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role_type
      when RoleType.admin then
        can :manage, :all
      when RoleType.manager then
        can :read, :all
      when RoleType.default then
        can :manage, Project
    end
  end
end
