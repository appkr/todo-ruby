# Todo application written in ruby

Laid here for personal study & reference purpose. This project is following-along of Perfect Ruby chapter 15 & 16.

```sh
$ git clone git@github.com:appkr/todo-ruby
```

## Console Application

```sh
$ cd todo-ruby/console
todo-ruby/console $ bundle install
todo-ruby/console $ touch storage/todo.db
todo-ruby/console $ bundle exec ruby bin/todo --help
```

## Web Application

```sh
$ cd todo-ruby/web
todo-ruby/web $ bundle install
todo-ruby/web $ touch storage/todo.db
todo-ruby/web $ bundle exec ruby bin/todo server
```

### Install as RubyGem

```sh
todo-ruby/web $ bundle exec rake build
# todo 0.2.0 built to pkg/todo-0.2.0.gem.

todo-ruby/web $ gem install pkg/todo-0.2.0.gem
# Successfully installed todo-0.2.0
# 1 gem installed

todo-ruby/web $ gem list todo
# *** LOCAL GEMS ***
# todo (0.2.0)

todo-ruby/web $ ln -s /usr/local/lib/ruby/gems/{X.Y.Z}/gems/todo-0.2.0/bin/todo /usr/local/bin/todo

todo-ruby/web $ todo server
# Start server process...
# [2016-06-22 23:03:50] INFO  WEBrick 1.3.1
# [2016-06-22 23:03:50] INFO  ruby 2.3.1 (2016-04-26) [x86_64-darwin15]
# [2016-06-22 23:03:50] INFO  WEBrick::HTTPServer#start: pid=16743 port=9292
# ^C[2016-06-22 23:03:59] INFO  going to shutdown ...
# [2016-06-22 23:03:59] INFO  WEBrick::HTTPServer#start done.
```