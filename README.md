# Benchmark illustrating DB pooling in Rails

Steps to run it:

1. Run `bundle install`
2. Run `./bin/rake db:create`. This will create the needed DB in your PG DB. You may need to setup the creds in config/database.yml
3. Run the server: `./bin/rails s -e production`
4. Test the endpoint which doesn't make DB calls: `ab -c 50 -n 200 http://127.0.0.1:3000/no_db`. It should complete all the requests successfully
5. Test the endpoint which makes DB calls: `ab -c 50 -n 200 http://127.0.0.1:3000/db`. There will be a lot of failed requests, because the threads won't be able to checkout connections from the DB
