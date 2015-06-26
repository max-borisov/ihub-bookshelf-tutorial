class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def belongs_to_user?(user)
    user.id == self.user.id
  end
end
