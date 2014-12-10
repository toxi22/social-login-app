## Instalation
```
$ git clone git@github.com:LaMaladieDespoir/ruby-test-job.git

$ cd ruby-test-job

$ bundle install

$ rake db:migrate
```
## Usage
For create 100 fake user:
```
$ rake fake:create_users
```
For send fake email to ruby-test-job@yandex.ru from ruby.test.job@gmail.com.
```
$ rake fake:send_email
```