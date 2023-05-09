# Random Points Generator

A simple phoenix app which a single endpoint, `\`
The app returns at max 2 users with more than a random number of points.

# How it Works

When the app starts , it launches genserver `RandomPointsGenerator` with an initial state having a `min_number` (a random number between 0 to 100) and a `timestamp`. The genserver runs every minute and updates every user's points in database and also refreshes the `min_number` of the genserver state with a new number and updates the `timestamp` as well. The app has a single public endpoint which queries postgres database for all users with more points than `min_number` but only retrieve a maximum of 2 users.

# Getting Started

To run this project, you will need to install the following dependencies on your system:

1.Elixir
2.Phoenix
3.PostgreSQL

To get started, run the following commands:

Clone the repository -

`git clone https://github.com/mansi-gupta29/api.git`

Install the required dependencies

`mix deps.get`

Edit config/dev.exs file and change the database related configuration as applicable to your system, create the database and runs the database migrations and seed file.

`mix ecto.setup`

Now you visit [`localhost:4000`](http://localhost:4000) from your browser.

# Response 

`{
  'users': [{id: 29, points: 31}, {id: 16, points: 90}],
  'timestamp': 2020-07-30 17:09:33
}`
