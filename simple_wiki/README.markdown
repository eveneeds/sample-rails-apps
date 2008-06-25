# jQuery and Ajax examples

Run rake app:install to bootstrap some sample data into the app.

A very simple Wiki system. It lets users create pages. Pages are revisioned, and users can list/show previous revisions of a page. A simple redcloth extension handles page-to-page links.

Note that you probably don't want to use this revisioning system for a live app, as it stores a dupe of every single revision. It does not use diffing to store only the differences between the changes or any other kind of fancy thing, it just makes raw copies of the entire row.

# Files of interest

* db/migrate/20080606191708_create_pages.rb (the extra 'revisions' table)
* lib/textile_cloth.rb (extending RedCloth with [[page]] links on the wiki)
* app/models/page.rb