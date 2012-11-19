module UsersHelper
  def username user, forum_id = nil
    content_tag :span, :class => user.role(forum_id) do
      user.name
    end
  end
end
