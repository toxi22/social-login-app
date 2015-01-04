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
## OmniAuth:
For Google-API:

Open https://console.developers.google.com - create your project. Activate "Google+ API" and "Contact API", then create "New client ID" and editing setting.yml:
```
omniauth:
...
  google:
    client_id: CLIENT_ID
    client_secret: CLIENT_SECRET
...
```
For Facebook-API:

Open https://developers.facebook.com/apps - create your app. Set "Web-site url" and "Contact email", then editing setting.yml:
```
omniauth:
...
  facebook:
    client_id: APP_ID
    client_secret: APP_SECRET
...
```
For VKontakte-API:

Open https://vk.com/apps?act=manage - create your app. Set "Web-site url" and editing setting.yml:
```
omniauth:
...
  vkontakte:
    client_id: APP_ID
    client_secret: APP_SECRET
...
```

For Twitter-API:

Open https://dev.twitter.com/apps - create your app. Set "Web-site url" and enable "Allow this application to be used to Sign in with Twitter", then editing setting.yml:

```
omniauth:
...
  twitter:
    client_id: Consumer_Key(API_KEY)
    client_secret: Consumer_Secret(API_SECRET)
...
```