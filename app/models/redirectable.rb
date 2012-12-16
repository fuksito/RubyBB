module Redirectable
  def self.included(base)
    base.has_many :redirections, :as => :redirectable, :dependent => :destroy
    base.after_update :save_redirection
  end

  private

  def save_redirection
    if self.slug != self.slug_was
      r = Redirection.find_or_create_by_redirectable_type_and_slug(:redirectable_type => self.class.to_s, :slug => self.slug_was)
      r.redirectable_id = self.id
      r.save
    end
  end
end
