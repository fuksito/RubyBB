module UsersHelper
  def username user, role_or_forum_id = nil
    if user
      link_to user, :class => role_or_forum_id.is_a?(String) ? role_or_forum_id : user.role(role_or_forum_id) do
        user.name
      end
    else
      'Anonymous'
    end
  end
end
