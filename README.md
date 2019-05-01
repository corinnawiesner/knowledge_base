# README

## Knowledge Base

### Ruby version
2.5.5

### Rails version
5.2.2.1

### System dependencies
- postgres
- redis

### Configuration
#### Copy files:
- `config/database.yml.example` to `config/database.yml`
- `.envrc.example` to `.envrc`

### Database creation
Run `$ bundle exec rake db:create`

### Database initialization
Run `$ bundle exec rake db:migrate`

### Resque worker start
Execute `$ QUEUE=* rake environment resque:work`

### Test suite
This project uses rspec for the test suite.
Run it with `$ bundle exec guard` for live testing or `$ bundle exec rspec` for manual testing.

### Services (job queues, cache servers, search engines, etc.)
- redis (background jobs)
- Amazon Translate (translation service)
