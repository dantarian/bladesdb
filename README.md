bladesdb
========

BathLARP game and character management webapp.

# Getting started

You'll need `rvm` installed. See http://rvm.io for more information.

You'll also need Bundler. Run `gem install bundler` once you've got your Ruby and gemset defined. Once that's done, do `bundle install`.

Assuming you've got a `db/development.sqlite3` file that's up-to-date, you can run up the app in a standalone server on localhost:3000 with the following command:

```
foreman start -f Procfile.dev -e development.env
```

If you don't, then you can create a blank database containing only the basic seed values using:

```
rake db:create
rake db:migrate
```
 
# Testing

Assuming that you've got everything installed and an up to date database, you can create a test database using:

```
rake db:test:clone_structure
```

You can then run the tests using:

```
rake cucumber
```

To run a specific feature or even more specific scenario, you can call them like this:

```
cucumber --require features --require lib features/subdir/test.feature:line
```

where line is the line number of the start of the scenario.