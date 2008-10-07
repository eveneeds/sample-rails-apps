# Print views

Run rake app:install to migrate the database and bootstrap some data into it.

Lets you easily create print views for your content. It uses a mime type for this, so that /posts renders the regular HTML view, and /posts.print renders the print version. This causes rails to automatically try to use a 'index.print.erb' view and an 'application.print.erb' layout, which means we don't have to implement anything. Rails conventions for the win!

It is important that the views for the various PostsController actions are named '[action_name].erb', not '[action_name].html.erb'. If you specify the mime, html, Rails won't try to use those templates when you're in the scope of the print mime (such as /posts.print). This is a regular Rails convention. Don't specify the mime of a template, and the template will be used for all mimes.

# Files of interest

* config/initializers/mime_types.rb
* app/views/layouts/application.print.erb
* app/views/layouts/application.html.erb (the 'Print this page' link)
