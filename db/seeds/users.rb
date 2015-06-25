User.create!([
               {
                 name: 'Tom',
                 email: 'tom@gmail.com',
               },
               {
                 name: 'Jack',
                 email: 'jack@gmail.com',
                 admin: true
               }
])
puts("#{User.count} user(s) have been created.")
