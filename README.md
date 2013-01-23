Assassins
==================================

Facebook Webapp for hosting games of [Assassin](http://en.wikipedia.org/wiki/Assassin_%28game%29).

Design
------

A user logs in (using facebook), to which a profile is kept in our database (stats and such).
Users can then sign up for games to participate in an keep track of current games.

Home - Shows a news feed of assassinations, and updates on game rules, leaderboard, etc.

Profile - Shows stats and other important information (nicknames?)

??? - Place to show current target, and submit a kill code (proof that you hit the other guy with a sock)

Rules - Yep, we have rules.

Dev page - Join the development

Requirements
------------

* Ruby 1.9.3
* Bundler gem
* sqlite3

Check your ruby version:
    
    ruby -v

List your gems:
    
    gem list


Instructions for Mac
--------------------

Download and install brew:

    ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

Download and install RVM:

```\curl -L https://get.rvm.io | bash -s stable --ruby```

Follow the instructions afterwards (may need other pkgs, 'source' new ruby version). Make sure your system is using the correct Ruby version (or higher); you may need additional rvm installs to do this.

Install bundler:

    gem install bundler


Run locally
-----------

Install dependencies:

    bundle install

Launch the app with [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html):

    foreman start

