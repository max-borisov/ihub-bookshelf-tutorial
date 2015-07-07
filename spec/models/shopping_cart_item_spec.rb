require 'rails_helper'

describe ShoppingCartItem do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
end
