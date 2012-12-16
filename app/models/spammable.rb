module Spammable
  def self.included(base)
    base.before_create :check_spam
    base.after_create :update_spam
  end

  private

  def check_spam
    return true if !user.last_post_at
    if user.last_post_at >= Time.now - 10
      errors[:spam] = "spam"
      user.update_column :human, false unless /:\/\//.match(content).nil?
      return false
    end
    return true
  end

  def update_spam
    user.update_column :last_post_at, Time.now
  end
end
