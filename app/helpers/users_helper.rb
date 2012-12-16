module UsersHelper
  def abbr short, long
    return short if short == long
    "<span title='#{long}'>#{short}</span>".html_safe
  end

  def username user, args = {}
    if user
      link_to user, :class => user.sysadmin ? 'sysadmin' : nil do
        args[:short] ? abbr(user.shortname, user.name) : user.name
      end
    else
      'Anonymous'
    end
  end
end
