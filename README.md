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
After having completed the installation process  
In the root directory, run `rake db:migrate db:seed` to create tables and populate the database  
Then, run `rackup -p 4567`  
Go to `http://localhost:4567/`


### CLI Usage
```
usage: watering_cli.rb [-d] [today/date in Y-M-D format] [-p] [specific plant] [-a] [show all]
```

------------------

### Test Suites
- Test for Big File Size

------------------

### Complexity


------------------

### Issues
- ~Disrespecting the MVC :(~
- ~Logic is too complicated~
- ~Plant date logic breaks for `water_after: 364 days` for some reason~
- ~Not~ maybe scalable

------------------

### Future Features
- Allow mistakes for people who water a day before/after the designated date, but also prevent overwatering/underwatering
- Images & Bio (with NAMEs!!!) for each Plants (API?) / support adding/editing new plants to Web
- I could set up a Cronjob to schedule plant dates
- Make CLI smarter with combined options (`-dp`)
- Caching the data?
- support loading another file in CLI
- supporting another method of seeding the database
- rubocop
- ~Better UI for specific pages (`/plants`)~
- ~ActiveRecord Time CLI (just 'cause)~ - watering_cli.rb :grin:
- ~Scrolling plant calendar on Web UI~ kind of -- it's got pagination(ish)
- ~Revisit logic & make it smarter -- it looks redundant in a few spots~
- ~if data gets large - a database for Web would probably be a good idea~ I made a db


------------------

### Version History
**0.2.0** Basic MVC                 - its basic
**0.1.0** watering_cli.rb           - separated into classes, also created web UI
**0.0.0** watering_cli_prototype.rb -  it works and it's brute forced
