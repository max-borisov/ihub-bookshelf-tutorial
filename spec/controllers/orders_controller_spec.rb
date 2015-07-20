require 'rails_helper'

describe OrdersController do
  context 'user is not signed in' do
    describe 'GET index' do
      it 'redirects user to the login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'redirects user to the login page' do
        post :create
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

    describe 'POST create' do
      it 'creates a new Order' do
        expect {
          post :create
        }.to change(Order, :count).by(1)
      end

      it 'redirects to the order page' do
        post :create
        expect(response).to redirect_to(orders_path)
      end
    end
  end
end
