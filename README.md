# BundlerDate

## What?

Bundle has great command `bundle outdated` to compare installed gems with newer versions available.
It does its job but there is one problem.

Let's try it:

```bash
$ bundle outdated

Gem              Current  Latest  Requested  Groups
loofah           2.14.0   2.15.0  = 2.14.0   default
sinatra          2.1.0    2.2.0   = 2.1.0    default
```
Okay, we see that we have almost edge versions of each gem. The difference is one minor version for both.
Is it a big difference? We can't say definitely.

But at least we can check when these versions were released. What will we see?
* `loofash 2.14.0` was released in February 2022, `2.15.0` in March 2022
* `sinatra 2.1.0` was released in 2020(!), `2.2.0` was released in 2022.

See the difference? `bundle date` try to show it more explicit.

```bash
$ bundle date
 Gem              Current  Current Date  Latest  Latest Date  Days between 

 loofah           2.14.0   2022-02-11    2.15.0  2022-03-14   31           
 sinatra          2.1.0    2020-09-04    2.2.0   2022-03-19   561          
```

## Installation

Specify the plugin in your Gemfile:

```ruby
plugin 'bundler_date'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ bundle plugin install bundler_date

## Usage

    $ bundle date
