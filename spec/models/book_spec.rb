require 'rails_helper'

describe Book do
  it { should have_many(:reviews).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:pub_date) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:isbn) }
  it { should validate_presence_of(:description) }

  it { should validate_length_of(:title).is_at_most(150) }
  it { should validate_length_of(:author).is_at_most(150) }

  it { should validate_length_of(:isbn).is_at_most(12) }
  it { should allow_value('370208728-1').for(:isbn) }

  it { should validate_length_of(:amazon_id).is_at_most(50) }
  it { should allow_value('1783981881').for(:amazon_id) }

  it { should validate_uniqueness_of(:isbn).with_message('is not unique') }
  it { should validate_uniqueness_of(:amazon_id).with_message('is not unique') }

  it { should validate_numericality_of(:price) }

  context 'When book is saved' do
    it 'fills keywords field' do
      book = create(:book)
      keywords = [book.title, book.author, book.isbn, book.amazon_id].join(' ').strip
      expect(book.keywords).to eq(keywords)
    end
  end

  describe 'Search book by keywords' do
    let(:book_php) { create(:book, title: 'PHP') }
    let(:book_ruby) { create(:book, title: 'Ruby') }

    it 'returnes array of books' do
      expect(Book.search('PHP')).to eq([book_php])
    end
  end
end
