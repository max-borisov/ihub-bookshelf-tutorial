require 'rails_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  it { should validate_presence_of(:text) }

  describe '#belongs_to_user?' do
    let(:tom) { create(:user, email: 'tom@gmail.com') }
    let(:jack) { create(:user, email: 'jack@gmail.com') }
    let(:review) { build(:review, user: tom) }

    it 'returnes true if a review belongs to specified user' do
      expect(review.belongs_to_user?(tom)).to be true
    end

    it 'returnes false if a review does not belong to a user' do
      expect(review.belongs_to_user?(jack)).to be false
    end
  end
end
