class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    unless user.new_record?
      can :create, Message do |o|
        !user.banned?(o.forum_id)
      end

      can :create, Topic do |o|
        !user.banned?(o.forum_id)
      end

      can :manage, Message do |o|
        user.id == o.user_id || user.moderator?(o.forum_id)
      end

      can :manage, Topic do |o|
        user.id == o.user_id || user.admin?(o.forum_id)
      end

      can :manage, Forum do |o|
        user.sysadmin? o.id
      end

      can :manage, Role do |o|
        user.sysadmin? o.forum_id
      end

      can :manage, User do |o|
        user.sysadmin? :all
      end
    end
  end
end
