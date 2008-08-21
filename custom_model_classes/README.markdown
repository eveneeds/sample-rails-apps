# Custom model classes

Use a class other than ActiveRecord as your model backend. You can adapt this system to use text files, csv files, or anything you can parse, as your data storage.

# Files of interest

* lib/yaml_record.rb
* db/posts.yml
* app/models/post.rb
* app/controllers/posts.rb (the point: it looks just as if you'd be using ActiveRecord)