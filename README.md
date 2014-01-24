# MassInsert [![Build Status](https://travis-ci.org/alejandrogutierrez/mass_insert.png?branch=master)](https://travis-ci.org/alejandrogutierrez/mass_insert) [![Coverage Status](https://coveralls.io/repos/alejandrogutierrez/mass_insert/badge.png)](https://coveralls.io/r/alejandrogutierrez/mass_insert)

This gem aims to provide an easy and faster way to do single database insertions in Rails.
Support Mysql, PostgreSQL and SQLite3 adapters. It depends on ActiveRecord.

## Installation

Add this line to your application's Gemfile:

    gem 'mass_insert'

And then execute:

    $ bundle install

Or install it yourself with:

    $ gem install mass_insert

## Advantages

Faster. It's depending of the computer but these are some results...

* PostgreSQL - Saving 10,000 records in 0.49s

## Attention

Since this is a single database insertion your model validations will be ignored, then if you use this gem you need to be sure that information is OK to be persisted.

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
      }
    ]

And call mass_insert method from your model:

    User.mass_insert(values)


## Results

Sometimes after MassInsert process you need to see information about the process. MassInsert provides a simple way to do it. Just call the next methods from your model after MassInsert execution.

    User.mass_insert_results.records                    # => 120000

Some result options are...

1. `records` : Returns the amount of records that were persisted.
2. `time` : Returns the time that took to do all the MassInsert process.
3. `building_time` : Returns the time that took to create the query string that was persisted.
4. `execution_time` : Returns the time that took to execute the query string that was persisted.


## Options

MassInsert accepts options hash by second param when you call `mass_insert` from your model. These options allow you to configure the way that records will be persisted. Example...

    options = {
      :some_option => some_value,
      :some_option => some_value
    }

    User.mass_insert(values, options)

OR directly

    User.mass_insert(values, :option => value)

Some options you can include are...

**Primary key**

By default primary key is generated automatically. If you wish to set primary key manually you need to pass the `primary_key` option on true. Example...

    User.mass_insert(values, :primary_key => true)

**Each slice**

Due you can get a database timeout error you can specify that the insertion will be in batches. Just pass the `each_slice` option with the records per batch. Example...

    User.mass_insert(values, :each_slice => 10000)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
