first_order = Order.first.id
last_order = Order.last.id

rails = Book.where(amazon_id: 1941222196).first[:id]
yii2 = Book.where(amazon_id: 1783981881).first[:id]
ruby = Book.where(amazon_id: 1934356476).first[:id]

OrderItem.create!([
                    {
                      order_id: first_order,
                      book_id: rails,
                    },
                    {
                      order_id: first_order,
                      book_id: yii2,
                    },
                    {
                      order_id: first_order,
                      book_id: ruby,
                    },
                    {
                      order_id: last_order,
                      book_id: ruby,
                    }
])
puts("#{OrderItem.count} order item(s) have been created.")
