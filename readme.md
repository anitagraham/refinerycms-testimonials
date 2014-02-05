# Testimonials plugin for RefineryCMS
http://github.com/resolve/Refinery

Version 2.0 is a rewrite of the original refinerycms-testimonials. It is compatible with Refinerycms 2.0

## How to install

In your Gemfile, add the gem:

```ruby
gem 'refinerycms-testimonials', '~> 2.0'
```

Now, run `bundle install` and the gem should install.

To install the migrations, run:

    rails generate refinery:testimonials
    rake db:migrate
    rake db:seed

## Add Testimonials to the database


You can now add testimonials to the database through the Refinery CMS.
The testimonials fields are
+ quote (the actual testimonial)
+ name (of testimonial sender)
+ company ( ditto )
+ website ( ditto )
+ jobtitle ( ditto )
+ received_channel (letter, email, facebook, twitter)

##Control Testimonial display on a page

Each page now has a testimonials tab which can be used to decide how testimonials should be displayed on that page

+ Show Testimonials on this page (default:  __no__)
+ How many testimonials to show (n, __0__ means show all)
+ How to select and order which testimonials to show (Random, __Most Recent First__)


## Changes to Layout Templates

See Enabling Custome Layout Templates in this [refinery guide](http://refinerycms.com/guides/using-custom-view-or-layout-templates]

To override the standard refinery application layout do
rake refinery:override view=layouts/application

This will create the file app/views/layouts/application.html.erb

Testimonials  in a layout template.
For example, in application.html.erb

````ruby
<%=  yield :testimonials %>
````

For more control over what is displayed the @testimonials collection is available for you to render as html or json.



