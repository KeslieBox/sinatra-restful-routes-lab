class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/' do
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  get '/recipes/new' do
    @recipe = Recipe.new

    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe_name = @recipe.name
    @recipe_ingredients = @recipe.ingredients
    @recipe_cook_time = @recipe.cook_time
    @recipe_id = @recipe.id

    erb :show
  end

  get '/recipes/:id/edit' do
    binding.pry
    @recipe = Recipe.find_by(id: params[:id])
    @recipe_name = @recipe.name
    @recipe_ingredients = @recipe.ingredients
    @recipe_cook_time = @recipe.cook_time
    @recipe_id = @recipe.id

    erb :edit
  end

  patch '/recipes/:id' do
    binding.pry
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    erb :show
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete

    redirect '/recipes'
  end

end
