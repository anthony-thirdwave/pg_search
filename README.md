# Postgres Search Engine
This is a forked blog application to test the pg search engine.

#### Setup
You will need to do a few things to set up the pg search engine.

1. First create a new rails app.
  * ```
    $ rails new myapp -d postgresql
    ```

2. Now you will need to add postgres extensions to your databases for function support
  * ```
    rails g migration add_contrib_extensions
    ```

    ```ruby
    class AddContribExtensions < ActiveRecord::Migration
      def up
        execute 'CREATE EXTENSION pg_trgm;'
        execute 'CREATE EXTENTION fuzzystrmatch;'
      end
    end
    ```

3. You will also need to format your schema to sql
  * In your ```config/application.rb``` file add this code: ```config.active_record.schema_format = :sql```

4. Add ```ruby gem 'pg_search'``` do your gemfile

5. Run bundle.

6. Create migrations for dmetaphone and multi-table search (if needed) support

    ```
    $ rails g pg_search:migration:dmetaphone
    $ rails g pg_search:migration:multisearch
    ```

7. Create and migrate
  ```$ bundle exec rake db:create; bundle exec rake db:migrate```

8. Configure the model(s)

    ```ruby
    class Post
      include PgSearch
      multisearchable against: [:title, :body]
    end
    ```

9. Create an initializer to configure PgSearch. This is where all the custom settings go.

    ``` $ touch config/initializers/pg_search.rb ```

    ```ruby
    PgSearch.multisearch_options = {
      using: {
        tsearch:    {dictionary: 'english'},
        trigram:    {threshold: 0.1}, # lower threshold gives more results for incorrect grammar
        dmetaphone: {}
      }
    }
    ```

10. Create some objects in the seeds file and populate the database

    ```ruby
    Post.create title: 'Jon Snow', body: 'Winter is coming. The Starks must prevail!'
    Post.create title: 'Arya Stark', body: 'Arya Stark is pretty cool'
    ```

11. Run the search in the console
  ``` $ rails c ```

  ```ruby
  search = PgSearch.multisearch 'stork'
  search.map { |s| s.searchable.title }.inspect
  ```
