bladesdb
========

[![Build Status](https://github.com/dantarian/bladedb/workflows/continuous-integration/badge.svg)](https://github.com/dantarian/bladesdb/actions?query=workflow%3Acontinuous-integration)

BathLARP game and character management webapp.

# Getting started

You'll need `rvm` (or some other Ruby version management tool) installed. See http://rvm.io for more information.

You'll also need Bundler. Run `gem install bundler` once you've got your Ruby and gemset defined. Once that's done, do `bundle install`.

Assuming you've got a `db/development.sqlite3` file that's up-to-date, you can run up the app in a standalone server on localhost:3000 with the following command:

```
foreman start -f Procfile.dev -e development.env
```

If you don't, then you can create a blank database containing only the basic seed values using:

```
rake db:setup
```
 
# Testing

Assuming that you've got everything installed and an up to date database, you can create a test database using:

```
bundle exec rake db:schema:load
bundle exec rake db:test:prepare
```

Unit tests can be run with:

```
bundle exec rails test
```

System tests can be run with:

```
bundle exec cucumber
```

If you get a failure, you can rerun just the failed tests with:

```
bundle exec cucumber -p rerun
```

To run a specific feature or even more specific scenario, you can call them like this:

```
bundle exec cucumber --require features --require lib features/subdir/test.feature:line
```

where line is the line number of the start of the scenario.
