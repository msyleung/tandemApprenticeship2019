# Tandem Apprenticeship 2019 Challenge
## Prompt: We grow in Tandem! :plant-emoji:

### Goal
Your goal is to create an application that generates a watering schedule for the next 12 weeks for all of our plants.

<!-- We would also like to see a README which includes any information about how to run the code, any known issues or complexity we should look out for, and any additional features you would like to have added to make your scheduler even more awesome. -->

------------------

### Assumptions / Rules
- We do not water our plants on a weekend. Work-life balance is important, and we shouldn't be in the office on a weekend.
- Our plants are reasonably tolerant and will still be happy if they are watered a day before or after the day they should be watered.
- Watering an individual plant takes no time at all so you don't have to worry about how many plants can be watered in a particular day.
- The scheduling should start from next Monday and last for 12 weeks.
- All plants will be watered on the first day of the schedule (next Monday).
- We recognize that when to water a plant is heavily dependent on other factors such as soil, weather, humidity, etc. You can assume that we know exactly when to water these specific plants. You have been provided a JSON file which contains data for our plants.

------------------

### Installation
In the root directory  
Run `bundle install`

------------------

### Web Usage
Visit Heroku: https://tandem-apprenticeship2019.herokuapp.com/

Or install locally via Installation
In the root directory, run `rake db:migrate db:seed` to create tables and populate the database  
Then, run `rackup -p 4567`  
Go to `http://localhost:4567/`  


### CLI Usage
```
Usage: ruby watering_cli.rb [-g guide] [-v] [-d date] date string in 'Y-M-D' format [-p plant] specific plant name [-a show all]
```

------------------

### Test Suites
`rake db:test:prepare`
`rspec -I . --format doc`
- Test for 5 year difference in dates (big data)

```
Day
  basic functionality
    runs
    can use Day class methods
  validity of Day
    is valid with valid attributes
    is valid with nil attributes
    is not valid with pre-existing date
  class method count_day
    should equal 2 days for days between Dec 7 and Dec 9
    should equal 0 days for days between Dec 7 and Dec 7
    should equal -14 days for days between Dec 21 and Dec 7
  class method check_weekday
    should go from Sunday to Monday

Plant
  basic functionality
    runs
  validity of Plant
    is valid with valid attributes
    is valid with nil attributes
    is not valid with 0 water after days
```

------------------

### Future Features
- Allow mistakes for people who water a day before/after the designated date, but also prevent overwatering/underwatering
- Images & Bio (with NAMEs!!!) for each Plants (API?) / support adding/editing new plants   
Web with :point_up_2: `gem 'friendly_id'` and use 'slug' for plants :snail:
- I could set up a Cronjob to schedule plant dates - `gem 'sidekiq'`
- Make CLI smarter with combined options (`-dp`)
- Caching the data?
- support loading another file in CLI
- supporting another method of seeding the database (CRUD for Plants & Days)
- rubocop
- ~Calendar frontend view~
- ~Better UI for specific pages (`/plants`)~
- ~ActiveRecord Time CLI (just 'cause)~ - watering_cli.rb :grin:
- ~Scrolling plant calendar on Web UI~ kind of -- it's got pagination(ish)
- ~Revisit logic & make it smarter -- it looks redundant in a few spots~
- ~if data gets large - a database for Web would probably be a good idea~ I made a db

------------------

### Dependencies
```
PLATFORMS
  ruby

DEPENDENCIES
  activesupport
  better_errors
  calendar_helper (~> 0.2.6)
  pg
  pry
  rake
  rspec
  sinatra (= 2.0.7)
  sinatra-activerecord
  sinatra-contrib

RUBY VERSION
   ruby 2.4.1p111

BUNDLED WITH
   1.17.3
```

------------------

### Resources

#### Structure
Structuring Sinatra Applications - https://nickcharlton.net/posts/structuring-sinatra-applications.html

#### Testing
Sinatra Tests 101 - RSpec - https://binarylies.ghost.io/sinatra-tests-101/
Testing a Sinatra app - http://testing-for-beginners.rubymonstas.org/rack_test/sinatra.html
Model Testing in RSpec for a Sinatra App - https://backend.turing.io/module2/lessons/model_testing_in_rspec_for_sinatra_app
