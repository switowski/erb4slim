# Erb4slim
[![Code Climate](https://codeclimate.com/github/switowski/erb4slim/badges/gpa.svg)](https://codeclimate.com/github/switowski/erb4slim)
[![Build Status](https://travis-ci.org/switowski/erb4slim.svg?branch=master)](https://travis-ci.org/switowski/erb4slim)

Gem that allows you quickly convert ERB templates to Slim.
It combines the usage of `html2haml` and `haml2slim` gems.
You can use it either to convert a single file, all files in a directory or all files recursively starting from a specific directory.
By combining the `recursive` and `delete` options you can replace all the `.html.erb` files with `.html.slim` in a project with one command.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erb4slim'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erb4slim

## Usage

To see the available options simply call:

    $ erb4slim

## Contributing

If you have any ideas for new features let me know or create a pull request.