# Members-Only (Secret-Club)

In this exclusive club, members can share their secret thoughts about non-members. Insiders can see who the author of a post is but, outsiders can only see the secret and wonder who wrote it.

# Built With
 - Ruby on Rails 6

## Installation

- Clone repo and run `bundle install`. 

## Model Tests

I decided to implement specs early on during the creation of each `Model`.

- Run `rails test:models` in the console to verify that tests pass. 

## Model Design

- The site can have users. 
- Users can make posts. 

### Features
+ Clean looking UI
+ Search field to quickly search for a post(s).
+ Supprt 3 distinct post views (all, paginated, story).
+ Post stats to provide quick overview about posts
+ Full athentication and authorization flow
+ Remember-Me feature to persist session
+ Admin who can delete all or a single post
+ Entire pagination feature is self-written (no gem) 
+ Web content is self-written

# Live Version
#### URL [Start Sharing Secrets](https://secretclub.herokuapp.com/)

# Author
+ Saintaze [@saintaze](https://github.com/saintaze/)
