tom = User.where(email: 'tom@gmail.com').first[:id]
jack = User.where(email: 'jack@gmail.com').first[:id]

rails = Book.where(amazon_id: 1941222196).first[:id]
yii2 = Book.where(amazon_id: 1783981881).first[:id]
ruby = Book.where(amazon_id: 1934356476).first[:id]

ShoppingCartItem.create!([
               {
                 user_id: tom,
                 book_id: rails,
               },
               {
                 user_id: tom,
                 book_id: yii2,
               },
               {
                 user_id: tom,
                 book_id: ruby,
               }
])
puts("#{ShoppingCartItem.count} cart item(s) have been created.")
