tom = User.where(email: 'tom@gmail.com').first[:id]

Order.create!([
               {
                 user_id: tom,
                 total_price: 299.89,
               },
               {
                 user_id: tom,
                 total_price: 150,
               }
])
puts("#{Order.count} order(s) have been created.")
