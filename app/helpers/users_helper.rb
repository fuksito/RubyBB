module UsersHelper
  def abbr short, long
    return short if short == long
    "<span title='#{long}'>#{short}</span>".html_safe
  end

  def username user, role_or_forum_id = nil, args = {}
    if user
      link_to user, :class => role_or_forum_id.is_a?(String) ? role_or_forum_id : user.role(role_or_forum_id) do
        args[:short] ? abbr(user.shortname, user.name) : user.name
      end
    else
      'Anonymous'
    end
  end
end
