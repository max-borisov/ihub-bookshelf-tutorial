require 'rails_helper'

describe User do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:shopping_cart_items).dependent(:destroy) }
  it { should have_many(:books).through(:shopping_cart_items) }
  it { should have_many(:orders).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  describe 'public methods' do
    let(:tom) { build(:user) }
    let(:jack) { build(:user) }
    let(:book_php) { build(:book, title: 'PHP', price: 25.25) }
    let(:book_ruby) { build(:book, title: 'Ruby', price: 25.25) }

    describe '#book_in_shopping_cart?' do
      before do
        create(:shopping_cart_item, user: tom, book: book_php)
      end

      it 'returns true if specified book belongs to shopping cart' do
        expect(tom.book_in_shopping_cart?(book_php)).to be true
      end

      it 'returns false if specified book does not belong to shopping cart' do
        expect(jack.book_in_shopping_cart?(book_php)).to be false
      end
    end

    describe '#shopping_cart_total_price' do
      it 'returns shopping cart total price, which is $50.50' do
        create(:shopping_cart_item, user: tom, book: book_php)
        create(:shopping_cart_item, user: tom, book: book_ruby)
        expect(tom.shopping_cart_total_price).to eq(50.50)
      end
    end

    describe '#shopping_cart_items_amount' do
      it 'returns shopping cart items amount, which is 3' do
        create_list(:shopping_cart_item, 3, user: tom)
        expect(tom.shopping_cart_items_amount).to eq(3)
      end
    end
  end
end
