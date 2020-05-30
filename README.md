# mellow (back end)

## Background

Mental health is a topic that is close to my heart. Recently, I have been doing a lot of research around mindfulness and meditation, and how these simple practices can improve mood, reduce stress, and contribute to an improved sense of wellbeing. 

Throughout my journey thus far I have used several applications for guided meditation and mindfulness. While mindfulness applications (such as Headspace) are amazing for guided meditations, they often lack features around tracking wellness, mood, and past meditations. Therefore, I set out to build an application that not only provides tools during meditation, but also helps track the quality of your meditations over time. Additionally, the app aims to track other physical factors, such as water intake and daily exercise, to how these practices map to your daily mood over time.

## App Architecture

- App is split into two discrete services: the **server-side** (back end) and **client-side** (front end)
- Back end built using **Ruby on Rails** (version 5.2.4.3)
- Front end built using **React + Redux**

## Installation Instructions for this Repo (back end)

- Install Ruby (version 2.5.1)
- Install Ruby on Rails (version 5.2.4.3)
- Install PostgreSQL
- Clone this repository
- Run `bundle install` to install necessary dependencies
- Run `rake db:migrate` to create the tables in your local DB
- Run `rails s` to start the server


## Automated Testing

- To run all available tests simply run `rspec`
- Automated tests implemented using **rspec-rails** in combination with factory_bot_rails, shoulda_matchers, database_cleaner, and faker. 

    - factory_bot_rails makes the process of creating mock fixtures much simpler
    - shoulda_matchers is used to provide base RSpec with additional matchers
    - database_cleaner ensures a clean mock database for each new test suite
    - faker is a handy library for generating mock data

- Opted to use requests integration testing instead of basic controller unit testing to test the entire stack (routes --> controller --> to DB)

- Tried to ensure near **100% test coverage** for all models and endpoints

## Endpoints

### `/check_ins`

#### **GET** `/check_ins` will return all available check_in items

**Example:**

Request: `/check_ins`

Response:

```
[
    {
        "id": 5,
        "date_submitted": "2020-01-10",
        "mood": 5,
        "nutrition_rating": 3,
        "cups_of_water": 8,
        "activity_rating": 5,
        "sleep_hours": 8,
        "did_meditate": true,
        "meditation_rating": 3,
        "created_by": null,
        "created_at": "2020-05-30T06:03:43.160Z",
        "updated_at": "2020-05-30T06:03:43.160Z"
    },
    {
        "id": 6,
        "date_submitted": "2020-01-11",
        "mood": 3,
        "nutrition_rating": 3,
        "cups_of_water": 5,
        "activity_rating": 3,
        "sleep_hours": 8,
        "did_meditate": true,
        "meditation_rating": 2,
        "created_by": null,
        "created_at": "2020-05-30T06:04:34.040Z",
        "updated_at": "2020-05-30T06:04:34.040Z"
    }
```
<br/>
<br/>

#### **POST** `check_ins` is used to create a new entry

**Example:**

Request: `/check_ins'
Request body (JSON): 

```
{
    "mood": 5,
    "date_submitted": "2020-01-17",
    "nutrition_rating": 2,
    "cups_of_water": 8,
    "activity_rating": 1,
    "sleep_hours": 3,
    "meditation_rating": 1,
    "did_meditate": "False"
}
```

Response:

```
{
    "id": 8,
    "date_submitted": "2020-01-17",
    "mood": 5,
    "nutrition_rating": 2,
    "cups_of_water": 8,
    "activity_rating": 1,
    "sleep_hours": 3,
    "did_meditate": true,
    "meditation_rating": 1,
    "created_by": null,
    "created_at": "2020-05-30T06:08:15.562Z",
    "updated_at": "2020-05-30T06:08:15.562Z"
}
```
<br/>
<br/>


#### GET `/check_ins/between_dates` is used for retriving all check_in items between a certain submited_date range

**Example**:


Request: `/check_ins/between_dates?start_date=2020-01-10&end_date=2020-01-12`

Response:

```
[
    {
        "id": 5,
        "date_submitted": "2020-01-10",
        "mood": 5,
        "nutrition_rating": 3,
        "cups_of_water": 8,
        "activity_rating": 5,
        "sleep_hours": 8,
        "did_meditate": true,
        "meditation_rating": 3,
        "created_by": null,
        "created_at": "2020-05-30T06:03:43.160Z",
        "updated_at": "2020-05-30T06:03:43.160Z"
    },
    {
        "id": 6,
        "date_submitted": "2020-01-11",
        "mood": 3,
        "nutrition_rating": 3,
        "cups_of_water": 5,
        "activity_rating": 3,
        "sleep_hours": 8,
        "did_meditate": true,
        "meditation_rating": 2,
        "created_by": null,
        "created_at": "2020-05-30T06:04:34.040Z",
        "updated_at": "2020-05-30T06:04:34.040Z"
    }
]
```
<br/>
<br/>

#### GET `/check_ins/:id` is used for getting a check_in item by ID

**Example:**

Request: `/check_in/5`

Response:

```
{
    "id": 5,
    "date_submitted": "2020-01-17",
    "mood": 5,
    "nutrition_rating": 2,
    "cups_of_water": 8,
    "activity_rating": 1,
    "sleep_hours": 3,
    "did_meditate": true,
    "meditation_rating": 1,
    "created_by": null,
    "created_at": "2020-05-30T06:03:43.160Z",
    "updated_at": "2020-05-30T06:18:52.443Z"
}
```
<br/>
<br/>

#### PUT `check_ins/:id` is used for updating a check_in item by ID

**Example:**

Request: `/check_ins/5?mood=3`

Response:

(No response)

<br>

#### DELETE `check_ins/:id` is used for deleting a check_in item by ID

**Example:**

Request: `/check_ins/5`

Response:

(No response)

