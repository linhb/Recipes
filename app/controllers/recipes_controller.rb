class RecipesController < ApplicationController
  def index
    @recipes = Recipe.search(params[:search]).paginate page: params[:page], per_page: 30 
  end
  
  def show
    @recipe = Recipe.find(params[:id]).scale(params[:serving])
    unless @recipe.valid?
      flash[:error] = @recipe.errors.full_messages.join("<br />").html_safe # TODO move HTML logic into helper
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    if params[:unparsed_contents]
      @recipe = Recipe.new.parse(params[:unparsed_contents])
    else
      @recipe = Recipe.new(params[:recipe])
    end
    if @recipe.save
      flash[:success] = "Recipe saved"
      redirect_to recipes_path
    else
      flash.now[:error] = @recipe.errors.full_messages.join("\n")
      render action: 'index'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to(recipes_path, notice: 'Recipe was successfully updated.') 
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to :back
  end
end
