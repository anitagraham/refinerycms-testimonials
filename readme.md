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

Testimonials can be associated with a Refinery Page using a testimonials Tab which the extension adds to the page editor.

By default testimonials are displayed as a multiple select tag.

These can be displayed as a two-sided select box using javascript, or could be shown with checkboxes.

To change the select to checkboxes you can over-ride the partial that creates the tab.

```shell
$ rails refinery:override view=testimonials/admin/testimonials/tabs/_select_testimonials
```

*('select' in the filename indicating a choice, rather than a select statement.)*

To get check boxes, replace the `collection_select` in that file with 

```ruby
collection_check_boxes(:page, :testimonial_ids, @testimonials, :id, :name)
```

## Changes to Views or Layout Templates

See Enabling Custom Layout Templates in this [refinery guide](http://refinerycms.com/guides/using-custom-view-or-layout-templates)

## Views


Somewhere in a view or layout you will need to call a  testimonials partial.

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
<%= render 'myTestimonials', @page.testimonials %>
````



