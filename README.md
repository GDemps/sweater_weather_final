## Sweater Weather API

### Overview

Sweater Weather is a 5-day final-project completed by [Grant Dempsey](https://github.com/GDemps) in Module 3 of the back-end program at Turing School of Software and Design. It is a the back-end of a mock Road-Trip Application. It consumes the [OpenWeather API](https://openweathermap.org/api/one-call-api) and the [MapQuest API](https://developer.mapquest.com/documentation/geocoding-api/) and exposes the data consumed in an API that the front-end of this application would use. This API also handles user registration, login, and authentication.

### Setup

**Git Setup**

```
$ git clone git@github.com:GDemps/sweater_weather_final.git
$ cd sweater_weather_final
$ bundle install
```

**Database**

```
$ bundle exec rails db:{create,migrate}
```

**Testing**

```
$ bundle exec rspec
```

### Versions

```
  Rails 5.1.7
  Ruby 2.5.3
```

### Testing

Rspec was used to test all of the endpoints. This includes sad path testing for 400 level testing as well as unit testing.

### Schema

![Schema](https://i.imgur.com/U7spMG2.png)

### Endpoints

All endpoints can be reached by running  `rails server` and navigating to `http://localhost:3000/`

#### Get the forecast for a city

Request:

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

Response:

```
body:

{:data=>
  {:id=>nil,
   :type=>"forecast",
   :attributes=>
    {:location=>"Denver, CO US",
     :current=>
      {
        :dt=>1596488024,
         :sunrise=>1596456076,
         :sunset=>1596507046,
         :temp=>85.23,
         :feels_like=>80.94,
         :humidity=>33,
         :uvi=>10.4,
         :visibility=>10000,
         :weather=>[{
                     :id=>802,
                     :main=>"Clouds",
                     :description=>"scattered clouds",
                     :icon=>"03d"
                    }]
      },
     :hourly=>
      [{
        :dt=>1596484800,
        :temp=>85.23,
        :weather=>[{
                    :id=>802,
                    :main=>"Clouds",
                    :description=>"scattered clouds",
                    :icon=>"03d"
                  }]
      {...}
      }],
     :daily=>
      [{:dt=>1596481200,
        :weather=>[{
                    :id=>500,
                    :main=>"Rain",
                    :description=>"light rain",
                    :icon=>"10d"
                  }],
        :rain=>0.43,
        :temp=>{:min=>74.71, :max=>87.64}},
        {...}
      ]}}}
```

#### Get a background image for a city

Request:

```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

Response:

```
body:

{:data=>
 {:id=>nil,
  :type=>"image",
  :attributes=>
      {:url=>
         "https://images.unsplash.com/photo-1546156929-a4c0ac411f47?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE1MzY0MH0"
      }
  }
}
```

#### User Registration

Request:

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

Response:

```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### User Login

Request:

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

Response:

```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### Road Trip

Request:

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

Response:

```
status: 200
body:

{:data=>
 {:id=>nil,
  :type=>"road_trip",
  :attributes=>
   {:origin=>"Denver, CO",
    :destination=>"Pueblo, CO",
    :travel_time=>6402,
    :arrival_forecast=>
     {:dt=>1596488400,
       :temp=>81.18,
       :weather=>[{
                    :id=>500,
                    :main=>"Rain",
                    :description=>"light rain", :icon=>"10d"
                  }]
      }
    }
  }
}
```

### Error Handling

#### User Registration

Passwords Don't Match:

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
  "password_confirmation": "different_password"
}
```

Response:

```
status: 400
body:

{
  :data=>
    {:id=>nil,
      :type=>"error",
      :error_message=>"Password confirmation doesn't match Password"
    }
  }
```

Missing Required Fields:

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "",
  "password": "password"
  "password_confirmation": "different_password"
}
```

Response:

```
status: 400
body:

{
  :data=>
    {:id=>nil,
      :type=>"error",
      :error_message=>"Email can't be blank"
    }
  }
```

#### User Login

Wrong Password:

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "wrong_password"
}
```

Response:

```
status: 400
body:

{
  :data=>
    {:id=>nil,
      :type=>"error",
      :error_message=>"Credentials are bad"
    }
  }
```

#### Road Trip

Incorrect API key:

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "wrong_key"
}
```

Response:

```
status: 401
body:

{
  :data=>
    {:id=>nil,
      :type=>"error",
      :error_message=>"Credentials are bad"
    }
  }
```
