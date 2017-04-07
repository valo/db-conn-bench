# Benchmark illustrating DB pooling in Rails

Steps to run it:

1. Run `bundle install`
2. Run `./bin/rake db:create`. This will create the needed DB in your PG DB. You may need to setup the creds in config/database.yml
3. Run the server: `./bin/rails s -e production`
4. Test the endpoint which doesn't make DB calls: `ab -c 50 -n 200 http://127.0.0.1:3000/no_db`. It should complete all the requests successfully
5. Test the endpoint which makes DB calls: `ab -c 50 -n 200 http://127.0.0.1:3000/db`. There will be a lot of failed requests, because the threads won't be able to checkout connections from the DB

## Results

### Endpoint without DB queries

```
This is ApacheBench, Version 2.3 <$Revision: 1706008 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 100 requests
Completed 200 requests
Finished 200 requests


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /no_db
Document Length:        7 bytes

Concurrency Level:      50
Time taken for tests:   4.379 seconds
Complete requests:      200
Failed requests:        0
Total transferred:      66000 bytes
HTML transferred:       1400 bytes
Requests per second:    45.67 [#/sec] (mean)
Time per request:       1094.760 [ms] (mean)
Time per request:       21.895 [ms] (mean, across all concurrent requests)
Transfer rate:          14.72 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.0      0       4
Processing:  1003 1078  35.6   1091    1136
Waiting:     1003 1078  35.4   1090    1135
Total:       1003 1079  35.9   1091    1138

Percentage of the requests served within a certain time (ms)
  50%   1091
  66%   1096
  75%   1099
  80%   1106
  90%   1121
  95%   1131
  98%   1135
  99%   1137
 100%   1138 (longest request)
 ```

 ### Endpoint with DB queries

 ```
 This is ApacheBench, Version 2.3 <$Revision: 1706008 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 100 requests
Completed 200 requests
Finished 200 requests


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /db
Document Length:        1 bytes

Concurrency Level:      50
Time taken for tests:   21.350 seconds
Complete requests:      200
Failed requests:        97
   (Connect: 0, Receive: 0, Length: 97, Exceptions: 0)
Non-2xx responses:      97
Total transferred:      193422 bytes
HTML transferred:       143372 bytes
Requests per second:    9.37 [#/sec] (mean)
Time per request:       5337.615 [ms] (mean)
Time per request:       106.752 [ms] (mean, across all concurrent requests)
Transfer rate:          8.85 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   0.6      0       3
Processing:  1052 4878 862.2   5061    6035
Waiting:     1052 4878 862.2   5061    6035
Total:       1054 4879 862.0   5061    6035
WARNING: The median and mean for the initial connection time are not within a normal deviation
        These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)
  50%   5061
  66%   5075
  75%   5121
  80%   5127
  90%   5145
  95%   5961
  98%   5987
  99%   6017
 100%   6035 (longest request)
 ```
