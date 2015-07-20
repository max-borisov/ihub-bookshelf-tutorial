class Book < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  before_save :set_keywords

  validates :title, :author, :pub_date, :price, :isbn, :description, presence: true
  validates :title, :author, length: { maximum: 150 }
  validates :isbn, length: { maximum: 12 }, format: { with: /\A[\d\-]+\z/ }
  validates :amazon_id, length: { maximum: 50 }, format: { with: /\A[\dA-Z]+\z/ }
  validates :isbn, :amazon_id, uniqueness: { message: 'is not unique' }
  validates :price, numericality: true

  def self.search(keywords)
    where('keywords LIKE :keywords', keywords: "%#{keywords}%") if keywords.present?
  end

  private

  def set_keywords
    self.keywords = [title, author, isbn, amazon_id].join(' ').strip
  end
end
