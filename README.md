# TEST APP: STRIPE CART | Development Guide

This README would normally document whatever steps are necessary to get the
application up and running.


## Ruby Version
ruby 2.7.1

## Rails Version
rails 6.1.4

## PostgresSQL configuration (development)
After Rails App is created, it is possible that it will generate an error.
To fix the problem:

* Under the project folder & the specific gemset (rvm) open the terminal and run:

        gem install pg -v 'X.X.X' -- --with-pg-config='/Applications/Postgres.app/Contents/Versions/9.6/bin/pg_config'
* Replace X.X.X for the specific version that the pg gem is requiring, for example 1.2.3
* Make sure the folder points to where you have installed PG (postgreSQL)
* After pg was successfully installed, run again

        bundle install

## jQuery Installation
https://www.botreetechnologies.com/blog/introducing-jquery-in-rails-6-using-webpacker
* Under the project folder, open the terminal and run:

        yarn add jquery
* Go to app/config/webpack/environment.js and add the following code:

        const webpack = require('webpack')
        environment.plugins.prepend('Provide',
            new webpack.ProvidePlugin({
                $: 'jquery/src/jquery',
                jQuery: 'jquery/src/jquery'
            })
        )

* Go to app/javascript/packs/application.js and add the following:

        require("jquery")
        
        // jQuery Keywords declared
        window.jQuery = $;
        window.$ = $;

## TailwindCSS Installation
https://dev.to/webdevchallenges/add-tailwind-2-to-rails-6-1-3f5f

For Rails 6.1

1. Install through Yarn


    yarn add tailwindcss@npm:@tailwindcss/postcss7-compat postcss@7 autoprefixer@9

2. Generate tailwind config
   1. This command should create a tailwind.config.js file at the root of your project with the default theme configuration inside. As I stated before, I prefer to have my tailwind.config.js file live inside app/stylesheets. You'll need to create this folder as it won't exist initially


    npx tailwindcss init --full

3. Add purge paths to the newly generated file (tailwind.config.js) to reduce the css file dramatically


    purge: [
      "./app/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/javascript/**/*.js",
      "./app/javascript/**/*.vue",
    ],

4. Require tailwindcss in postcss
   1. At the root of your Rails project, you should find a postcss.config.js file. Inside this file will already be some code. We're going to append more to the file. I prefer the following format:


    // postcss.config.js

    require('tailwindcss')('./app/javascript/stylesheets/tailwind.config.js'),

5. Create the main CSS file where we import Tailwind CSS specific modules
   1. Inside app/stylesheets create a new file called application.scss (or whatever you prefer here). This file will be what we import inside our default app/javascript/packs/application.js file. Since this is all generated with JavaScript, this is all totally possible


    /* app/javascript/stylesheets/application.scss */

    @import "~tailwindcss/base";
    @import "~tailwindcss/components";

    // You can add your own custom components/styles here

    @import "~tailwindcss/utilities";

6. Next, we need to import this file into our app/javascript/packs/application.js file


    // app/javascript/packs/application.js
    
    require("@rails/ujs").start()
    require("turbolinks").start()
    require("@rails/activestorage").start()
    require("channels")
    
    // Tailwind CSS
    import "stylesheets/application" // ADD THIS LINE

7. Update layout template. Inside the <head>, update to the following tags


    <!-- app/views/layouts/application.html.erb -->

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>

## Tailwind SVG Icons
https://heroicons.com/

* Install the gem


    gem "heroicon"

* Install in Rals


    rails g heroicon:install

* Usage (examples)


    <%= heroicon "search" %>
    <%= heroicon "search", variant: :outline %>
    <%= heroicon "search", options: { class: "text-primary-500" } %>

## AlpineJS for TailwindCSS
https://btihen.me/post_ruby_rails/rails_6_1_tailwind_2_0_alpinejs/
* Install via CDN (check AlpineJS documentation)


* Install via Yarn


    yarn add alpinejs
    yarn add alpine-turbo-drive-adapter

* Add AlpineJS to application.js


    /* app/javascript/packs/application.js */
    
    // import alpinejs and its necessary rails adaptation
    import 'alpine-turbo-drive-adapter'
    require("alpinejs")

## MaterializeCSS Installation
https://medium.com/@guilhermepejon/how-to-install-materialize-css-in-rails-6-0-0-beta2-using-webpack-347c03b7104e
* Start by creating a new folder named 'stylesheets' inside:

        app/javascript
* Under app/javascript/stylesheets create a new file named:

        application.scss
* Import the file we just created in the js manifest under app/javascript/packs/application.js

        import '../stylesheets/application';           
* Go to app/views/layouts/application.html.erb and replace stylesheet_link_tag for:

        <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
* Install materialize through Yarn:

        yarn add materialize-css
* Import materialize in the js manifest under app/javascript/packs/application.js

        import 'materialize-css/dist/js/materialize';          
* Go to app/javascript/stylesheets/application.scss and add to he first line the following:

        @import "~materialize-css/dist/css/materialize";
* Finally go to app/views/layouts/application.htm and add materializeCSS icons in the HEAD

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

## Bootstrap 4 Installation
https://medium.com/@guilhermepejon/how-to-install-bootstrap-4-3-in-a-rails-6-app-using-webpack-9eae7a6e2832
* Similar to materializeCSS installation, follow link for more detail.

## Foreman (ONLY FOR DEV)
Real-time compilation gem. Follow these steps in development environment:
* Install Gem

        gem install foreman

* Create Procfile.dev in the app root folder

        # Procfile.dev        
        web: bundle exec puma -C config/puma.rb
        webpacker: ./bin/webpack-dev-server

* Start Foreman

        foreman start -f Procfile.dev

## In case Rails server doesn't start (Webpacker)
* Install yarn using your OS package manager, or take a look at https://yarnpkg.com/en/docs/install
* Install Webpacker:

        rails webpacker:install
* Make sure all packages are up to date:

        yarn install --check-files
* Start your Rails server:

        rails s

## Remove ms indicator (top left)
* Comment out the following gem


    # gem 'rack-mini-profiler'
* Or add to the url


    ?pp=disable
    ?pp=enable

## Database Setup
* The first time run

        run rake db:create

* Run migrations

        run rake db:migrate


## NGrok - Public URLs for testing Webhooks
https://dashboard.ngrok.com/get-started/setup

* To start an HTTP tunnel forwarding to your local port 3000, run this command from the folder where ngrok is located:


    >> ./ngrok http 3000

* Web interface


    http://127.0.0.1:4040/inspect/http

## Check Rails Routes from Web
* In the browser, go to:


    http://localhost:3000/rails/info/routes


# TEST APP: STRIPE CART | Deployment Guide
* Deploy to Heroku via Git


* DB Migrations
  

    heroku run rake db:migrate --app stripe-cart-staging
    heroku run rake db:migrate --app stripe-cart-prod



# Other Topics to Include

* System dependencies

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

