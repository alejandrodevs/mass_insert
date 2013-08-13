# MassInsert [![Build Status](https://travis-ci.org/alejandrogutierrez/mass_insert.png?branch=master)](https://travis-ci.org/alejandrogutierrez/mass_insert)

This gem aims to provide an easy and faster way to do single database insertions in Rails.
Support Mysql, PostgreSQL, SQLite3 and SQLServer adapters.

## Installation

Add this line to your application's Gemfile:

    gem 'mass_insert'

And then execute:

    $ bundle install

Or install it yourself with:

    $ gem install mass_insert

## Advantages

Faster. It's depending of the computer but these are some results...

* PostgreSQL - Saving 10,000 records in 0.84s

## Attention

Since this is a single database insertion your model validation will be ignored, then if you use this gem you need to be sure that information is OK to be persisted.

## Basic Usage

To use MassInsert gem you need to call mass_insert method from your ActiveRecord model and pass it an array with the values that you want to persist into the database.

The array of values:

    values = [
      {
        :name   => "Jay",
        :email  => "tremendous_gamer@gmail.com",
        :age    => 15
      },
      {
        :name   => "Beverly",
        :email  => "nippy_programmer@gmail.com",
        :age    => 24
      },
      {
        :name   => "Scottie",
        :email  => "angry_programmer@gmail.com",
        :age    => 32
      }
    ]

And call mass_insert method from your model:

    User.mass_insert(values)


## Results

Sometimes after MassInsert process you need to see some necessary information about the process. MassInsert gem provides a simple way to do it. Only call the next methods from your model after MassInsert execution.

    User.mass_insert_results.records                    # => 120000

Some result options are...

1. `records` : Returns the amount of records that were persisted.
2. `time` : Returns the time that took to do all the MassInsert process.
3. `building_time` : Returns the time that took to create the query string that was persisted.
4. `execution_time` : Returns the time that took to execute the query string that was persisted.


## Options

MassInsert accepts options hash by second param when you call `mass_insert` from your model. This options allow you to configure the way that the records will be created. Example...

    options = {
      :primary_key => :user_id,
      :primary_key_mode => :manual
    }

    User.mass_insert(values, options)

OR directly

    User.mass_insert(values, :primary_key => :user_id, :primary_key_mode => :manual)

Some options that you can include are...

**table_name**
- Default value is the table name to your model. This options rarely needs to change but you can do it if you pass a string with the table name. Example...

    options = {:table_name => "users"}

**primary_key**
- Default value is `:id`. You can change the name of primary key column send it a symbol with the column name.

    options = {:primary_key => :post_id}

**primary_key_mode**
- Default value is `:auto`. When is `:auto` MassInsert knows that the database will generate the value of the primary key column automatically. If you pass `:manual` as primary key mode you need to create your value hashes with the key and value of the primary key column.

    options = {:primary_key_mode => :manual}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
