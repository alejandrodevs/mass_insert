# MassInsert
[![Build Status](https://travis-ci.com/alejandrodevs/mass_insert.svg?branch=master)](https://travis-ci.org/alejandrodevs/mass_insert) [![Coverage Status](https://coveralls.io/repos/github/alejandrodevs/mass_insert/badge.svg?branch=master)](https://coveralls.io/github/alejandrodevs/mass_insert?branch=master)

This gem aims to provide an easy and faster way to do single database insertions in Rails. Support Mysql, PostgreSQL and SQLite3 adapters. It depends on ActiveRecord.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mass_insert'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mass_insert

## Usage

To use MassInsert gem you need to call `mass_insert` method from your ActiveRecord model
and pass it an array with the values that you want to persist into the database.

```ruby
values = [
  {
    name:   'Jay',
    email:  'tremendous_gamer@gmail.com',
    age:    15
  },
  {
    name:   'Beverly',
    email:  'nippy_programmer@gmail.com',
    age:    24
  }
]

User.mass_insert(values)
```

### Allow primary key

Sometimes you can need to insert records forcing primary keys.
Just pass the `primary_key` option with true. Example...

```ruby
values = [
  {
    id:     1000, # Force primary key.
    name:   'Jay',
    email:  'tremendous_gamer@gmail.com',
    age:    15
  }
]

User.mass_insert(values, primary_key: true)
```

### Insertion per batches

Due you can get a database timeout error you can specify that the insertion will be in batches.
Just pass the `per_batch` option with the records per batch. Example...

```ruby
User.mass_insert(values, per_batch: 1000)
```

### Handle unique index on MySQL

Sometimes we want to ignore errors when adding duplicated records. MySQL has
the ability to do that with `ON DUPLICATE KEY UPDATE`. By using the option
`handle_duplication` we will ignore the new values by doing:

```ruby
User.mass_insert(values, handle_duplication: true)
```

```sql
INSERT INTO table (a,b,c) VALUES (1,2,3)
  ON DUPLICATE KEY UPDATE a=a,b=b,c=c;
```

[Read more about MySQL ON DUPLICATE KEY UPDATE...](http://dev.mysql.com/doc/refman/5.7/en/insert-on-duplicate.html)

## Advantages

Faster. It depends on the computer and the data but these are some results...
* PostgreSQL - Saving 10,000 records in 0.49s

## Attention

Since this is a single database insertion your model validations will be ignored,
then if you use this gem you need to be sure that information is OK to be persisted.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alejandrodevs/mass_insert. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MassInsert project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alejandrodevs/mass_insert/blob/master/CODE_OF_CONDUCT.md).
