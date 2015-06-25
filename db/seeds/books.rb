amazon = ['1941222196', '1783981881', '1934356476', '0321984137', '1937785564', '1449373712', '1430223634', '1617291099', '1617291692', '1449321054', '1449373194', '144934013X', '1491901888', '1941222269']

amazon.each do |amazon_id|
  Book.create!({
                 title:        Faker::Name.title,
                 author:       Faker::App.author,
                 pub_date:     Faker::Date.between(rand(10..360).days.ago, Date.today),
                 description:  Faker::Lorem.paragraphs(rand(1..4)).map{ |i| "<p>#{i}</p>" }.join(''),
                 price:        Faker::Commerce.price,
                 isbn:         Faker::Code.isbn,
                 amazon_id:    amazon_id
  })
end
puts("#{Book.count} book(s) have been created.")
