module ApplicationHelper
  def user_gravatar(email, size = 200)
    'http://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(email) + '?s=' + size.to_s
  end
end
