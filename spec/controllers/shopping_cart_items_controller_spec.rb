require 'rails_helper'

describe ShoppingCartItemsController do
  let(:book) { create(:book) }

  context 'user is not signed in' do
    describe 'GET index' do
      it 'redirects user to the login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'redirects user to the login page' do
        post :create, book_id: book.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirects user to the login page' do
        delete :destroy, id: book.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'user is signed in' do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:authenticate_user!).and_return(user)
    end

    describe 'GET index' do
      it 'exposes shopping cart items' do
        shopping_cart_item = create(:shopping_cart_item, user: user)
        get :index
        expect(assigns(:items)).to eq([shopping_cart_item])
      end
    end

    describe 'POST create' do
      it 'creates a new shopping cart item' do
        expect {
          post :create, book_id: book.to_param
        }.to change(ShoppingCartItem, :count).by(1)
      end

      it 'redirects to the books catalog page' do
        post :create, book_id: book.to_param
        expect(response).to redirect_to(books_path)
        expect(flash[:notice]).to eq("\"#{book[:title]}\" has been added to your shopping cart")
      end

      context 'item wasn\'t saved' do
        it 'redirects to the book page' do
          allow_any_instance_of(ShoppingCartItem).to receive(:save).and_return(false)
          post :create, book_id: book.to_param
          expect(response).to redirect_to(book_path(book))
          msg = "\"#{book[:title]}\" could not be added to your shopping cart. Please, try again."
          expect(flash[:danger]).to eq(msg)
        end
      end
    end

    context 'deletes item from his/her shopping cart' do
      let!(:shopping_cart_item) { create(:shopping_cart_item, user: user) }

      it 'destroys the requested item' do
        expect {
          delete :destroy, id: shopping_cart_item.to_param
        }.to change(ShoppingCartItem, :count).by(-1)
      end

      it 'redirects to the shopping cart page' do
        delete :destroy, id: shopping_cart_item.to_param
        expect(response).to redirect_to(shopping_cart_items_path)
        msg = "\"#{shopping_cart_item.book.title}\" has been removed for the shopping cart"
        expect(flash[:notice]).to eq(msg)
      end
    end

    context 'deletes item from other user\'s shopping cart' do
      it 'redirects to the books catalog page' do
        user2 = build(:user)
        shopping_cart_item = create(:shopping_cart_item, user: user2)
        delete :destroy, id: shopping_cart_item.to_param
        expect(response).to redirect_to(books_path)
      end
    end
  end
end
