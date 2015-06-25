## 1. Create rails project

Commit link [909090](http://)

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

Commit link [909090](http://)

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

Commit link [909090](http://)

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

## 4. Create seed files

Commit link [909090](http://)

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

Commit link [909090](http://)

Example how we can generate controllers. Views and assets files will be generated as well.
```console
$ rails generate controller books index new create show edit update destroy
```


#### Related links

* [Action Controller Overview](http://guides.rubyonrails.org/action_controller_overview.html)

***

## 7. Routes

Commit link [909090](http://)

The Rails router recognizes URLs and dispatches them to a controller's action.

To get list of all available routes open terminal window and type:

```console
$ rake routes
```

#### Related links

* [Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)

***

## 8. Update main layout

Commit link [909090](http://)

#### Related links

* [Haml](http://haml.info/)
* [Html to haml](http://htmltohaml.com/)

***

## 9. Books catalog

Commit link [909090](http://)

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

