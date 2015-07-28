require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe 'DELETE destroy' do
    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:authenticate_user!).and_return(user)
    end

    it 'destroys the requested user' do
      expect {
        delete :destroy, id: user.to_param
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the registration page' do
      delete :destroy, id: user.to_param
      expect(response).to redirect_to(new_user_registration_path)
      expect(flash[:notice]).to eq('User account has been deleted')
    end

    context 'destroy other user\'s account' do
      let(:user2) { create(:user, email: 'tom@gmail.com') }

      it 'redirects to the login page' do
        delete :destroy, id: user2.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
