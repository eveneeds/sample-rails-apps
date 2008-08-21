# Custom model classes

Use a class other than ActiveRecord as your model backend. This particular system, YamlRecord, stores stuff as YAML in db/[model name].yml. You can adapt this system to use text files, csv files - basically anything you can parse - as your data storage.

# TODO before running the app

* Rename or move db/posts_sample.yml to db/posts.yml

# Files of interest

* lib/yaml_record.rb
* db/posts.yml
* app/models/post.rb
* app/controllers/posts.rb (the point: it looks just as if you'd be using ActiveRecord)