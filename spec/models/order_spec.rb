require 'rails_helper'

describe Order do
  it { should belong_to(:user) }
  it { should have_many(:order_items).dependent(:destroy) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:total_price) }

  context 'when order was saved' do
    before do
      @tom = create(:user)
      create_list(:shopping_cart_item, 2, user: @tom)
      @order = create(:order, user: @tom)
    end

    it 'copies shopping cart items to order items' do
      expect(@tom.orders.find(@order[:id]).order_items.count).to eq(2)
    end

    it 'deletes items from shopping cart' do
      expect(@tom.shopping_cart_items.count).to eq(0)
    end
  end
end
