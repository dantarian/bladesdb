bladesdb
========

BathLARP game and character management webapp.

# Getting started

You'll need `rvm` installed. See http://rvm.io for more information.

You'll also need Bundler. Run `gem install bundler` once you've got your Ruby and gemset defined. Once that's done, do `bundle install`.

Assuming you've got a `db/development.sqlite3` file that's up-to-date, you can run up the app in a standalone server on localhost:3000 with the following command:

```
foreman start -f Procfile.dev
```
