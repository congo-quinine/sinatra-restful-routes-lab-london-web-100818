class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @new_recipe = Recipe.create(params)
    redirect "/recipes/#{@new_recipe.id}"
  end

  get '/recipes/:id' do
    @find_recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @edit_recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @update_recipe = Recipe.find(params[:id])
    new_hash = {}
    new_hash[:name] = params[:name]
    new_hash[:ingredients] = params[:ingredients]
    new_hash[:cook_time] = params[:cook_time]
    @update_recipe.update(new_hash)
    redirect "/recipes/#{@update_recipe.id}"
  end

  delete '/recipes/:id/delete' do
    delete_recipe = Recipe.find(params[:id])
    delete_recipe.destroy
    erb :index
  end




end






# Instructions
# Instead of keeping all your recipes on index cards (just like your grandma did!), we're going to be building a web app to store those recipes for you!
#
# Create a new table in the database to store the recipes. Recipes should have a name, ingredients (which can be written as one string containing all the ingredients), and cook_time.
#
# Make sure you have a corresponding model for your recipes.
#
# In the application_controller.rb, set up a controller action that will render a form to create a new recipe. This controller action should create and save this new recipe to the database.
#
# Again in the application_controller.rb, create a controller action that uses RESTful routes to display a single recipe.
#
# Create a third controller action that uses RESTful routes and renders a form to edit a single recipe. This controller action should update the entry in the database with the changes, and then redirect to the recipe show page
#
# Create a controller action (index action) that displays all the recipes in the database.
#
# Add to the recipe show page a form that allows a user to delete a recipe. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.
