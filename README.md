Tutorial for building a Rails application
===
[![Build Status](https://travis-ci.org/max-borisov/ihub-rails-bookshelf-tutorial.svg?branch=master)](https://travis-ci.org/max-borisov/ihub-rails-bookshelf-tutorial) [![Code Climate](https://codeclimate.com/github/max-borisov/ihub-rails-bookshelf-tutorial/badges/gpa.svg)](https://codeclimate.com/github/max-borisov/ihub-rails-bookshelf-tutorial) [![Test Coverage](https://codeclimate.com/github/max-borisov/ihub-rails-bookshelf-tutorial/badges/coverage.svg)](https://codeclimate.com/github/max-borisov/ihub-rails-bookshelf-tutorial/coverage)

### [Demo on heroku](https://rails-simple-todo.herokuapp.com/)

### [Wiki documentation](https://github.com/max-borisov/ihub-rails-bookshelf-tutorial/wiki) is also available (in progress)

### [Slides](http://slides.com/max-borisov/ihub-rails-bookshelf)

**Basic functionality:**

* User registration / login
* Add / edit / delete books by admin
* Books catalog
* Add / delete reviews
* Manage shopping cart
* Create / view orders

**Installation:**

1. clone repository to empty directory 
2. run `$ rake db:migrate` to apply database changes
3. run `$ rake db:seed` to fill in the app with data
4. run `rails server`
5. open url `http://localhost:3000`

You can login using predefined accounts:

* login: __tom@gmail.com__, password: 11111111
* login: __jack@gmail.com__, password: 11111111. It is admin account.

## 1. Create rails project

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/56c43ac32d8c388b0898012ec56d670de4b3e3a8)

First of all lets check if you have a ruby installed on your computer. Open a terminal and type `ruby -v`. You might see something like that:

```console
$ ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin14]
```
If you have ruby 2.0 or older, please update it to the newest version.

Lets check whether you have `rails gem`  on your system. Type in the terminal window `rails -v`.
Here is what I get:

```console
Rails 4.2.1
```

If you do not have `rails`, install it with a command `gem install rails`.

By the way, `gem list --local` returns a list of all installed gems.

Go to your home directory or any other folder and create a new rails project with command `rails new PROJECT-NAME`.

For example:

```console
$ cd ~/
$ rails new rails-bookshelf
```

#### Related links

* Ruby - [Ruby lang](https://www.ruby-lang.org/en/), [rbenv](https://github.com/sstephenson/rbenv), [RVM](https://rvm.io/rvm/upgrading)
* Rails - [Guide](http://guides.rubyonrails.org/getting_started.html)
* GIT - [Git immersion](http://gitimmersion.com/), [Git cheatsheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf)

***

## 2. Update Gemfile

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/58290b398cd16e035bd1e7d4a8464d830807afb5)

Gemfile(on the project root) stores the list of gems required for the project.

It is essential to run command `bundle install` after Gemfile was updated.

To make sure you have __bundler gem__ install run this command
```console
$ bundler -v
```

If you got error, install the gem
```console
$ gem install bundler
```

Install gems and dependencies.
```console
$ bundle install
```

#### Related links

* [Bundler](http://bundler.io/)

***

## 3. Models

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/a03341a350225ac4c0986153d65f41a30ab49ce7)

There will be 6 models:

* **user** - manage user accounts
* **book** - manage books
* **review** - manage reviews
* **shopping_cart_item** - manage user shopping cart
* **order** - manage orders
* **order_item** - manage order items

```console
$ rails generate model book title:string author:string description:text price:'decimal{10,2}' pub_date:date amazon_id:string:uniq isbn:string:uniq
```

```console
$ rails generate model review text:text user:references book:references
```

```console
$ rails generate model user name:string email:string:uniq admin:boolean
```

```console
$ rails generate model shopping_cart_item user:references book:references
```

```console
$ rails generate model order user:references total_price:'decimal{10,2}'
```

```console
$ rails generate model order_item order:references book:references
```

Apply migrations:

```console
$ rake db:migrate
```

This command will create the database and models. Also **db/schema.rb** file is available now.

By the way, the following will return the list of all available **rake commands**:

```console
$ rake -T
```

#### Related links

* [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html)
* [Active Record Migrations](http://guides.rubyonrails.org/active_record_migrations.html)
* [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
* [The Rails Command Line](http://guides.rubyonrails.org/command_line.html)

***

## 4. Create seed files

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/613168d948a2c325a903a797ec901f32867bfa35)

Seed data are used to populate a database.

Run this command in the terminal to fill in the database:

```console
$ rake db:seed
```

#### Related links

* [Seed data](http://www.railszilla.com/rails-seed-data-example/rails)
* [Faker gem](https://github.com/stympy/faker)
* [Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)

***

## 5. Rails console

You can use __rails console__ to work with tables and rows as with simple ruby objects.

Open terminal and type the following:
```console
$ rails console
```

Now you are able to run commands.

Get list of users:

```ruby
ap User.all
```

__ap__ - is a shortcut for the __awesome_print gem__ which shows objects in more friendly way.

Find user with id 1
```ruby
ap User.find(1)
```

Get all books
```ruby
ap Book.all
```

Get first book from the list
```ruby
ap Book.first
```

Get last review
```ruby
ap Review.last
```

Get first book title
```ruby
ap Book.first[:title]
```

Check is a last user admin
```ruby
ap User.last.admin?
```

Destroy all orders
```ruby
ap Order.destroy_all
```

Destroy first book
```ruby
ap Book.first.destroy
```

Get amount of users
```ruby
ap User.count
```

#### Related links

* [Rails console](http://guides.rubyonrails.org/command_line.html#rails-console)
* [Rails Console Shortcuts, Tips, and Tricks](https://pragmaticstudio.com/blog/2014/3/11/console-shortcuts-tips-tricks)
* [Active Record Query Interface](http://guides.rubyonrails.org/active_record_querying.html)

***

## 6. Controllers

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/6a5a5bbdcb090440ebde6c1c16c05f1170c90900)

Example how we can generate controllers. Views and assets files will be generated as well.
```console
$ rails generate controller books index new create show edit update destroy
```


#### Related links

* [Action Controller Overview](http://guides.rubyonrails.org/action_controller_overview.html)

***

## 7. Routes

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/784db991ff92356399489efbfe86bc53fd13cb8c)

The Rails router recognizes URLs and dispatches them to a controller's action.

To get list of all available routes open terminal window and type:

```console
$ rake routes
```

#### Related links

* [Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)

***

## 8. Update main layout

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/2acb2d3961d5fec5dc579326d8bad0b074248ce3)

#### Related links

* [Haml](http://haml.info/)
* [Html to haml](http://htmltohaml.com/)

***

## 9. Books catalog

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/72f2161e8a3c509ee5cd8218e583c7a57ef9219a)

#### Related links

* [Sass](http://sass-lang.com/)
* [The Rails Command Line](http://guides.rubyonrails.org/command_line.html)

***

## 10. Rails server

We need a web server to get requests from a browser and send responses back.

Rails is shipped with default web server called WEBrick. It's quite good for development and test environments.

To start the server open terminal window(do not close it after WEBrick is up and running) and type the following:

```console
$ rails server -p 4000
```

__-p__ parameter repesents a port the WEBrick is running on. You can set any other value. If you omitt __-p__ param a default fort 3000 will be used.

Now you can open a browser to go url
```
http://localhost:4000
```

#### Related links

* [Ruby Default Web Server](https://devcenter.heroku.com/articles/ruby-default-web-server)
* [WEBrick](https://rubygems.org/gems/webrick/versions/1.3.1)

***

## 11. Book page

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/29e725469d317b096fb1d33baa9b94ca9b670487)

#### Related links

* [WEBrick](https://rubygems.org/gems/webrick/versions/1.3.1)

***

## 12. Devise

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/dba6ca636891b3715a117d9ef8e322fe725360f8)

Devise is an authentication solution for Rails projects.

In order to make __devise__ work to the following:

1. `$ rails generate devise:install`
2. `$ rails generate devise user`
3. update migration file __db/migrate/xxxx_add_devise_to_users.rb__
4. `$ rake db:migrate`
5. update user model(app/models/user.rb)
6. restart the web server. Turn it off and run `$ rails s -p 4000` again
7. http://localhost:4000/users/sign_up and http://localhost:4000/users/sign_in are available now
8. if you want to configure the default views run the commmand
`$ rails generate devise:views -v registrations sessions`
9. update app/views/devise files

#### Related links

* [Devise gem](https://github.com/plataformatec/devise)

***

## 13. Update main layout

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/2f4ba006afed01a492560ef3a78a95c19521b5c4)

***

## 14. Shopping cart

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/2f4ba006afed01a492560ef3a78a95c19521b5c4)

***

## 15. Checkout and orders

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/6317b02824d5240161bc4273c5df16e7b1c0bfc8)

***

## 16. Book reviews

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/930203d4ee423c96d3a0d0cb033f6ec421e7cde6)

***

## 17. CRUD for books

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/dd2074669a9602cb0b15898a17a9ecd7748c7109)

***

## 18. Search books

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/1d5cfa69161ec88e21f86208112bd6ae0c338db5)

***

## 19. User profile

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/e57f30ad21e52d2d55c8f3b1e8f3df18b1485767)

***

## 20. Pagination

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/6addad4e6e650681b96e6170c2178b9a7c1206ec)

#### Related links

* [gem will_paginate](https://github.com/mislav/will_paginate)
* [gem bootstrap-will_paginate](https://github.com/yrgoldteeth/bootstrap-will_paginate)

***

## 21. Heroku

[Commit link](https://github.com/max-borisov/ihub-bookshelf-tutorial/commit/79eed2f515e0529f34bcb8d9b294959cadf07fa5)

Open a terminal, go to the project directory and the following:

1. `$ heroku create ihub-rails-bookshelf`
2. `$ heroku list`
3. `$ git push heroku master`
4. `$ heroku run rake db:schema:load`
5. `$ heroku run rake db:seed`
6. `$ heroku open`

#### Related links

* [Rails 4.x on Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails4#specify-ruby-version-in-app)
* [Rails Girls Guides](http://guides.railsgirls.com/heroku/)

***
