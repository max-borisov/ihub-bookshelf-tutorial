tom = User.where(email: 'tom@gmail.com').first[:id]

rails = Book.where(amazon_id: 1941222196).first[:id]
yii2 = Book.where(amazon_id: 1783981881).first[:id]
ruby = Book.where(amazon_id: 1934356476).first[:id]

Review.create!([
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: rails
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: rails
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: rails
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: rails
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: yii2
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: ruby
                 },
                 {
                   text: Faker::Lorem.paragraphs(rand(2..6)).join(' '),
                   user_id: tom,
                   book_id: ruby
                 },
])
puts("#{Review.count} reviews(s) have been created.")
