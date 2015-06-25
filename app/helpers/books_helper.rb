module BooksHelper
  def book_cover(title, amazon_id)
    if amazon_id.nil?
      url = "http://placehold.it/140x172"
    else
      url = "http://images.amazon.com/images/P/#{amazon_id}.01.ZTZZZZZZ.jpg"
    end
    image_tag(url, alt: title)
  end

  def format_pub_date(created_at, show_time = false)
    format = '%B %d, %Y' + (show_time === true ? ' %T' : '')
    Date.parse(created_at.to_s).strftime(format)
  end
end