# MassInsert
[![Build Status](https://travis-ci.org/alejandrodevs/mass_insert.png?branch=master)](https://travis-ci.org/alejandrodevs/mass_insert) [![Coverage Status](https://coveralls.io/repos/github/alejandrodevs/mass_insert/badge.svg?branch=master)](https://coveralls.io/github/alejandrodevs/mass_insert?branch=master)

This gem aims to provide an easy and faster way to do single database insertions in Rails.
Support Mysql, PostgreSQL and SQLite3 adapters. It depends on ActiveRecord.


## Installation
Add this line to your application's Gemfile:
```ruby
gem 'mass_insert'
```
Run the bundle command to install it.


## Advantages
Faster. It's depending of the computer but these are some results...
* PostgreSQL - Saving 10,000 records in 0.49s


## Attention
Since this is a single database insertion your model validations will be ignored,
then if you use this gem you need to be sure that information is OK to be persisted.


## Basic Usage
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


## Running tests
First at all copy `test/database.yml.example` to `test/database.yml` and update username and password
for every database adapters. Then, run the following to test the gem against all adapters.
```
bundle exec rake test:all
```


## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
