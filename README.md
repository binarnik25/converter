# Leadfeeder job interview assignment

#### The problem is solved! :tada:

## Technical overview


The application is builded in Ruby (v. 2.3.1p112). Application instance has method to fetch database. It gets the source `.csv` file when instance initialize. This actions are included in the `app:fetch_db` rake task.
Required gems are included in `Gemfile`. You can install their with bundler.

The application uses NoSQL database MongoDB. Hence, you have to create new database, which is called like `converter`. Get more information about [MongoDB interactions](https://docs.mongodb.com/manual/installation/).

In addition, there is a class `ExchangeRateConverter` to handle conversion of a USD value ­date pair to Euro value.

``ExchangeRateConverter.convert(100, '2013-­01-­13')``

returns what 100 USD was in euros on January 13, 2013.

Finally, the app is a subject of testing. Using RSpec, you can run tests in `spec` folder.

## Personal overview

I started from implementation of the basic behaviour with RSpec.
Eventually, I spent 14 hours for researching and developing. I moved step by step.

Have a nice converting! :money_with_wings:
