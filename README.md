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

And call mass_insert method:

    User.mass_insert(values)

## Attention

Since this is a single database insertion your model validation will be ignored, then if you use this gem you need to be sure that information is OK to be persisted.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
