# README

This API repository is the backend for my front end repository which can be found (here)["https://github.com/Topaz712/impawsibly_social_client"]

## What is this API?

This API serves as the backend for a social media pet application, allowing users to register their profile, add multiple pet profiles, create and join playdate events, post adorable pet pictures, and send friend requests to other pets

# Target audience for this app

This API is for all pet owner enthusiasts! Whether they own canines, felines, reptiles, and many other diverse critters. Those who have a pet and want to connect with other pet owners for playdates and socializing are in the right place here!

## What does this API do?

This API will handle user authentication, pet profile management, playdate event creation and joining, posting pictures, and managing friend requests between pets

## API architecture

## Main Aspects 

This API will will handle user registration and authentication to let a user sign up and login, pet profile management, playdate event scheduling/management, posting/uploading pictures, and handling friend requests

- The frontend will interact with the API through HTTP requests, sending and receiving data in JSON format
    - It will handle user authentication, retrieve and update pet profiles, create and join playdate events, post/upload pictures, and manage friend requests

This API will implement authentication using JWT 'JSON Web Tokens' which allow users to securely access their profiles and perform authorized actions 
  -  For secure user authentication, *Authorization* will be enforced to ensure that users can access and modify only their own data based on their role(owner) and ownership(pets)

## Setup Instructions

Make sure to have *Ruby on Rails* installed on your system and once you have it installed you can do the following to set this API on yours

1. Clone the project repository from GitHub
2. Go to the project directory/open with vscode
3. Install dependencies by running `bundle install`
4. Set up the database by running `rails db:create` and `rails db:migrate`
5. Start the Rails server by running rails server

## Ruby Version
- The Ruby version used in this project is ruby "3.2.0"

## Gems

Gems I added for the application

- gem 'bcrypt'
  - For password hashing and encryption
    
- gem 'jwt'
  - To generate and validate JSON Web Tokens 'JWT' for authentication purposes
  
- gem 'blueprinter'
  - To serialize which means to convert, Ruby objects into JSON API responses
 
Then for testing the application in the `group :development, :test do` added:

- gem "debug", platforms: %i[ mri mingw x64_mingw ]
  - To debug the application
    
- gem 'rspec-rails'
  -  A testing framework which has the Behavior-Driven Development 'BDD' approach, to be able to write clear and expressive tests that describe the expected behavior of features in my application
  
- gem 'factory_bot_rails'
  - Creates test data through factory objects, to set up realistic data scenarios for testing various parts of the application of ActiveRecord models

- gem 'faker'
  - Generates realistic fake data for testing purposes
 
- gem 'shoulda-matchers', '~> 6.0'
  -  Provides helpful matchers for RSpec tests, making tests easier to read and write


