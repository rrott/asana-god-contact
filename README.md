# AsanaGodContact

A God::Contacts class for sending notifications to Asana. God is an easy to configure, easy to extend monitoring framework written in Ruby.
http://godrb.com/
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'asana-god-contact'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asana-god-contact

## Usage

Configure our god file to use asana connector adding next code
```ruby
require 'asana-god-contact'

God.contact(:asana) do |c|
  c.name = 'asana'
  c.api_key       = "2D2R..........OG0iZru"
  c.workspace_id  = "49.....860"
  c.assignee      = "92.....302"
  c.projects      = "28.....959"
  c.folowers      = "92.....302"
end
```
where "api_key" is the key you get from your asana

Other params are apropriate ids of workspace, user, project and followers. Followers can be an array.

Add the name of your contact (c.name = 'asana') to be used as notification:

```ruby
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
      c.notify = ['asana']
    end
  end
  ```
