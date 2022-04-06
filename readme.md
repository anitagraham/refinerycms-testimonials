# Testimonials plugin for [Refinery CMS](https://github.com/refinery/refinerycms)
 Version 5.0 has breaking changes.
Although testimonials retain the same form, they are now associated with Refinery Pages via a `has_many, through` association.

## How to install

In your Gemfile, add the gem:

```ruby
gem 'refinerycms-testimonials', '~> 5.0'
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

## Displaying Testimonials

Testimonials can be associated with a Refinery Page using the testimonials Tab.



## Changes to Views or Layout Templates

See Enabling Custome Layout Templates in this [refinery guide](http://refinerycms.com/guides/using-custom-view-or-layout-templates)

## Views

Somewhere in a view or layout you will need to call the testimonials partial.

````erb
<section id='side'>
  <%= raw @page.content_for(:side) %>
  <%= render 'refinery/testimonials/testimonials' %>
</section>
````

will render the CMS content for a page part called 'side', followed by some testimonials.

For more control over what is displayed the `@testimonials` collection is available for you.
You can call your own partial to render the collection.

````erb
<%= render 'myTestimonials', :testimonials => @testimonials.as_json %>
````



