# Meteor CMS

Meteor CMS is a CMS for rapid development.

It was built with [Meteor](http://meteor.com).

## Setup

1. Install meteor in your $PATH

curl https://install.meteor.com | /bin/sh

2. Clone repository

3. Run meteor

cd meteorcms
meteor

- this will get dependencies, start mongo, start node

4. Go to localhost:3000

## Fixtures

On initial run, this will create fixture data for users, pages, posts, and fields.  To prevent this, delete server/fixtures.coffee

## Default User Credentials

email: beans@fake.com

password: abcde123

## TODOS

- separate session errors on front end and admin
- setup secure publishing
- setup customer soft delete
- add hard delete