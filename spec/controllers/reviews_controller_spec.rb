require 'rails_helper'

describe ReviewsController do
  let(:book) { create(:book) }
  let(:valid_attributes) { { text: 'New review' } }

  context 'user is not signed in' do
    describe 'POST create' do
      it 'redirects user to the login page' do
        post :create, review: valid_attributes, book_id: book.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirects user to the login page' do
        review = create(:review)
        delete :destroy, id: review.to_param, book_id: book.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'user is signed in' do
    let(:user) { create(:user) }

    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller.current_user).to receive(:admin?).and_return(false)
      allow(controller).to receive(:authenticate_user!).and_return(user)
    end

    describe 'POST create' do
      describe 'with valid params' do
        context 'format is html' do
          it 'creates a new Review' do
            expect {
              post :create, review: valid_attributes, book_id: book.id, format: 'html'
            }.to change(Review, :count).by(1)
          end

          it 'exposes a newly created review as #review' do
            post :create, review: valid_attributes, book_id: book.id, format: 'html'
            expect(assigns(:review)).to be_an_instance_of(Review)
            expect(assigns(:review)).to be_persisted
          end

          it 'redirects to the book review was added to' do
            post :create, review: valid_attributes, book_id: book.id, format: 'html'
            expect(response).to redirect_to(book)
            expect(flash[:notice]).to eq('New review has been added')
          end

          context 'review has not been saved' do
            it 'redirects to the book page' do
              allow_any_instance_of(Review).to receive(:save).and_return(false)
              post :create, review: valid_attributes, book_id: book.id, format: 'html'
              expect(response).to redirect_to(book)
              expect(flash[:danger]).to eq('Review could not be saved')
            end
          end
        end

        context 'format is js' do
          it 'creates a new Review' do
            expect {
              post :create, review: valid_attributes, book_id: book.id, format: 'js'
            }.to change(Review, :count).by(1)
          end

          it 'exposes a newly created review as #review' do
            post :create, review: valid_attributes, book_id: book.id, format: 'js'
            expect(assigns(:review)).to be_an_instance_of(Review)
            expect(assigns(:review)).to be_persisted
          end

          it 'renders "create" template' do
            post :create, review: valid_attributes, book_id: book.id, format: 'js'
            expect(response).to render_template('create')
          end

          context 'review has not been saved' do
            it 'renders \'error\' template' do
              allow_any_instance_of(Review).to receive(:save).and_return(false)
              post :create, review: valid_attributes, book_id: book.id, format: 'js'
              expect(response).to render_template('error')
            end
          end
        end
      end

      describe 'with invalid params' do
        context 'format is html' do
          before do
            allow_any_instance_of(Review).to receive(:save).and_return(false)
            post :create, review: valid_attributes, book_id: book.id, format: 'html'
          end

          it 'exposes a newly created but unsaved review' do
            expect(assigns(:review)).to be_a_new(Review)
          end

          it "redirects to the book page review was added at" do
            expect(response).to redirect_to(book)
          end
        end

        context 'format is js' do
          before do
            allow_any_instance_of(Review).to receive(:save).and_return(false)
            post :create, review: valid_attributes, book_id: book.id, format: 'js'
          end

          it 'exposes a newly created but unsaved review' do
            expect(assigns(:review)).to be_a_new(Review)
          end

          it "renders 'error' template" do
            expect(response).to render_template('error')
          end
        end
      end
    end

    describe 'DELETE destroy' do
      let!(:user2) { build(:user) }
      let!(:user2_review) { create(:review, user: user2, book: book) }
      let!(:user_review) { create(:review, user: user, book: book) }

      context 'user is admin' do
        before do          
          allow(controller.current_user).to receive(:admin?).and_return(true)
        end

        describe 'format html' do
          it 'destroys any review' do
            expect {
              delete :destroy, book_id: book.id, id: user2_review.id, format: 'html'
            }.to change(Review, :count).by(-1)
          end

          it 'redirects to the book page review belongs to' do
            delete :destroy, book_id: book.id, id: user2_review.id, format: 'html'
            expect(response).to redirect_to(book)
            expect(flash[:notice]).to eq('Review has been deleted')
          end
        end

        describe 'format js' do
          it 'destroys any review' do
            expect {
              delete :destroy, book_id: book.id, id: user2_review.id, format: 'js'
            }.to change(Review, :count).by(-1)
          end

          it 'renders \'destroy\' template' do
            delete :destroy, book_id: book.id, id: user2_review.id, format: 'js'
            expect(response).to render_template('destroy')
          end
        end
      end

      context 'user is not admin' do
        context 'deletes his own review' do
          describe 'format html' do
            it 'deletes the review' do
              expect {
              delete :destroy, book_id: book.id, id: user_review.id, format: 'html'
            }.to change(Review, :count).by(-1)
            end

            it 'redirects to the book page review belongs to' do
              delete :destroy, book_id: book.id, id: user_review.id, format: 'html'
              expect(flash[:notice]).to eq('Review has been deleted')
            end
          end

          describe 'format js' do
            it 'deletes the review' do
              expect {
              delete :destroy, book_id: book.id, id: user_review.id, format: 'js'
            }.to change(Review, :count).by(-1)
            end

            it 'renders \'destroy\' template' do
              delete :destroy, book_id: book.id, id: user_review.id, format: 'js'
              expect(response).to render_template('destroy')
            end
          end
        end
          
        context 'deletes other\'s user review' do
          it 'redirects to the books page' do
            delete :destroy, book_id: book.id, id: user2_review.id
            expect(response).to redirect_to(books_path)
            expect(flash[:danger]).to eq('Record not found')
          end
        end
      end
    end
  end
end
