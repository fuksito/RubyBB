module UsersHelper
  def username user, forum_id = nil
    link_to user, :class => user.role(forum_id) do
      user.name
    end
  end
end
