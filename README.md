* To build environment 

```
rails db:create db:migrate
rails start
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

Concerns:
    Structure....
    Not CSS...
    Time...
