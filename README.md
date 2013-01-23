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

Instructions for mac
--------------------
download brew by typing the following in a terminal

ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

Then download RVM by typing the following in a terminal

\curl -L https://get.rvm.io | bash -s stable --ruby

follow the instructions after wards if you need to do further commands after downloading RVM

Install foreman by typing the following in a terminal

gem install foreman

Then follow the instructions on "Run locally"

Run locally
-----------

Install dependencies:

    bundle install

Launch the app with [Foreman](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html):

    foreman start
