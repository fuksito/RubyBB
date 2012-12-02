class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Forum
    can :read, Topic
    can :read, Message
    can :read, SmallMessage
    can :read, User

    unless user.new_record?
      can [:read, :clear], Bookmark
      can [:read, :clear], Notification
      can [:create, :read], Follow

      can :manage, Follow do |o|
        user.id == o.user_id
      end

      can :create, Message do |o|
        !user.banned?(o.forum_id) &&
        (user.human? || user.messages.empty?)
      end

      can :create, SmallMessage do |o|
        !user.banned?(o.forum_id) && user.human?
      end

      can :manage, SmallMessage do |o|
        user.sysadmin? || user.id == o.user_id || user.moderator?(o.forum_id)
      end

      can :create, Topic do |o|
        !user.banned?(o.forum_id) &&
        (user.human? || user.topics.empty?)
      end

      can :manage, Message do |o|
        user.sysadmin? || user.id == o.user_id || user.moderator?(o.forum_id)
      end

      can [:read, :create, :update], Topic do |o|
        user.sysadmin? || user.id == o.user_id || user.admin?(o.forum_id)
      end

      can :pin, Topic do |o|
        user.sysadmin? || user.admin?(o.forum_id)
      end

      can [:update, :destroy], Forum do |o|
        user.sysadmin? || user.admin?(o.id)
      end

      can :position, Forum do |o|
        user.sysadmin?
      end

      can :create, Forum do |o|
        user.sysadmin?
      end

      can :manage, Role do |o|
        (!o.user || !o.user.sysadmin?) && o.user_id != user.id &&
        (user.sysadmin? || user.admin?(o.forum_id))
      end

      can :manage, User do |o|
        user.sysadmin?
      end

      can :bot, User do |o|
        user.sysadmin? || (user.moderator?(o.messages.first.try(:forum_id)) && !o.human)
      end
    end
  end
end
