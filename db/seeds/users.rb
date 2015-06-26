User.create!([
               {
                 name: 'Tom',
                 email: 'tom@gmail.com',
                 password: 11111111,
               },
               {
                 name: 'Jack',
                 email: 'jack@gmail.com',
                 password: 11111111,
                 admin: true
               }
])
puts("#{User.count} user(s) have been created.")
