class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all #paginate :page => params[:page], :per_page => PER_PAGE 
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to(recipes_path, :notice => 'Recipe was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to(recipes_path, :notice => 'Recipe was successfully updated.') 
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to(recipes_url) 
  end
end
