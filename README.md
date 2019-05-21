* To build environment 

```
rails db:create db:migrate
rails s
```

* To run test suite

```
rails test
```

* To create a user in the database

```
rails c
User.new(user_id: 'test', password: "1234", password_confirmation: "1234")
exit
```

* In order to check Fake Tweeter functionalities

Note that in order to not expose any private information, the client_id and client_secret were not commited (but the file is in the zip version). 
They are in a env variable file called 'app_environment_variables.rb' in the config folder and follow the bellow structure.

```
ENV['CLIENT_ID'] = 'your_client_id'
ENV['CLIENT_SECRET'] = 'your_client_secret'
```

* Other Concerns:
    - Structure. As this is a test and not a follow-up project, the structure and relations between model are simplified for a fast development.
    - No CSS. The CSS as well as a detailed class assigment of the DOM elements are omitted
    - Time. Around 9-10 hours of coding. 
