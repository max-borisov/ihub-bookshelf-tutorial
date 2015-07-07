require 'rails_helper'

RSpec.describe BooksHelper, :type => :helper do
  describe "book_cover" do
    let(:cover) { book_cover('Ruby') }

    it 'returnes an image tag' do
      expect(cover).to include('img')
    end

    it 'it sets alt attribute for image' do
      expect(cover).to include('alt="Ruby"')
    end

    context 'when amazon_id is not set' do
      it 'has image placeholder url' do
        expect(cover).to include('http://placehold.it/')
      end
    end

    context 'when amazon_id is set' do
      it 'has amazon images server url' do
        cover = book_cover('Ruby', 1941222196)
        expect(cover).to include("http://images.amazon.com/images/")
      end
    end
  end

  describe "format_pub_date" do
    it 'returnes formatted date' do
      expect(format_pub_date(Time.now)).not_to eq('')
    end
  end
end
