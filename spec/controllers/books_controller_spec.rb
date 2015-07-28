require 'rails_helper'

describe BooksController do
  let(:valid_attributes) { attributes_for(:book) }

  context 'user is not signed in' do
    describe 'GET index' do
      it 'exposes all books' do
        book = create(:book)
        get :index
        expect(assigns(:books)).to eq([book])
      end
    end

    describe 'GET search' do
      it 'applies search criteria and exposes books in the catalog' do
        create(:book, title: 'PHP')
        book_ruby = create(:book, title: 'Ruby')
        get :search, keywords: 'Ruby'
        expect(assigns(:books)).to eq([book_ruby])
      end
    end

    describe 'GET show' do
      it 'exposes the requested book' do
        book = create(:book)
        get :show, id: book.to_param
        expect(assigns(:book)).to eq(book)
        expect(assigns(:review)).to be_an_instance_of(Review)
      end
    end

    describe 'GET new' do
      it 'redirects user to the login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'redirects user to the login page' do
        post :create, book: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET edit' do
      it 'redirects user to the login page' do
        book = create(:book)
        get :edit, id: book.to_param
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT update' do
      it 'redirect user to the login page' do
        book = create(:book)
        put :update, id: book.to_param, book: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'redirect user to the login page' do
        book = create(:book)
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
      allow(controller.current_user).to receive(:admin?).and_return(false)
      allow(controller).to receive(:authenticate_user!).and_return(user)
    end

    context 'user is not admin' do
      describe 'GET new' do
        it 'redirects user to the books page' do
          get :new
          expect(response).to redirect_to(books_path)
          expect(flash[:alert]).to eq('Only admin can manage books')
        end
      end

      describe 'POST create' do
        it 'redirects user to the books page' do
          post :create, book: valid_attributes
          expect(response).to redirect_to(books_path)
        end
      end

      describe 'GET edit' do
        it 'redirects user to the books page' do
          book = create(:book)
          get :edit, id: book.to_param
          expect(response).to redirect_to(books_path)
        end
      end

      describe 'PUT update' do
        it 'redirect user to the books page' do
          book = create(:book)
          put :update, id: book.to_param, book: valid_attributes
          expect(response).to redirect_to(books_path)
        end
      end

      describe 'DELETE destroy' do
        it 'redirect user to the books page' do
          book = create(:book)
          delete :destroy, id: book.to_param
          expect(response).to redirect_to(books_path)
        end
      end
    end

    context 'user is admin' do
      let(:invalid_attributes) do
        attributes = attributes_for(:book)
        attributes[:email] = ''
        attributes[:price] = 'text'
        attributes
      end

      before do
        allow(controller.current_user).to receive(:admin?).and_return(true)
      end

      describe 'GET new' do
        it 'exposes a new book' do
          get :new
          expect(assigns(:book)).to be_a_new(Book)
        end
      end

      describe 'POST create' do
        describe 'with valid params' do
          it 'creates a new Book' do
            expect {
              post :create, book: valid_attributes
            }.to change(Book, :count).by(1)
          end

          it 'exposes a newly created book as #book' do
            post :create, book: valid_attributes
            expect(assigns(:book)).to be_an_instance_of(Book)
            expect(assigns(:book)).to be_persisted
          end

          it 'redirects to the created book' do
            post :create, book: valid_attributes
            expect(response).to redirect_to(Book.last)
          end
        end

        describe 'with invalid params' do
          it 'exposes a newly created but unsaved category' do
            allow_any_instance_of(Book).to receive(:save).and_return(false)
            post :create, book: invalid_attributes
            expect(assigns(:book)).to be_a_new(Book)
          end

          it "re-renders the 'new' template" do
            allow_any_instance_of(Book).to receive(:save).and_return(false)
            post :create, book: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'GET edit' do
        it 'exposes the requested book' do
          book = create(:book)
          get :edit, id: book.to_param
          expect(assigns(:book)).to eq(book)
        end
      end

      describe 'PUT update' do
        let(:book) { create(:book) }

        describe 'with valid params' do
          it 'updates the requested book' do
            attributes = valid_attributes.stringify_keys.transform_values(&:to_s)
            allow_any_instance_of(Book).to receive(:update).with(attributes)
            put :update, id: book.to_param, book: attributes
          end

          it 'exposes the requested book' do
            put :update, id: book.to_param, book: valid_attributes
            expect(assigns(:book)).to eq(book)
          end

          it 'redirects to the book' do
            put :update, id: book.to_param, book: valid_attributes
            expect(response).to redirect_to(book)
          end
        end

        describe 'with invalid params' do
          it 'exposes the book' do
            allow_any_instance_of(Book).to receive(:update).and_return(false)
            put :update, id: book.to_param, book: invalid_attributes
            expect(assigns(:book)).to eq(book)
          end

          it "re-renders the 'edit' template" do
            allow_any_instance_of(Book).to receive(:update).and_return(false)
            put :update, id: book.to_param, book: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE destroy' do
        let!(:book) { create(:book) }

        it 'destroys the requested book' do
          expect {
            delete :destroy, id: book.to_param
          }.to change(Book, :count).by(-1)
        end

        it 'redirects to the books list' do
          delete :destroy, id: book.to_param
          expect(response).to redirect_to(books_url)
        end
      end
    end
  end
end
