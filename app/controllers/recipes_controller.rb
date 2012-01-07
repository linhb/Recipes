require 'nokogiri'

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.search(params[:search]).paginate :page => params[:page], :per_page => 30 
    @recipe = Recipe.new
  end
  
  def show
    @recipe = Recipe.find(params[:id]).scale(params[:serving])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    # unless ((url = params[:recipe][:contents]) =~ /http:\/\//).nil?
      # raise url.inspect
      # body = Nokogiri::HTML(open(""))
      # raise body.inspect
    # else
      @recipe = Recipe.new(params[:recipe])
      if @recipe.save
        flash[:success] = "Recipe saved"
        redirect_to recipes_path
      else
        flash.now[:error] = @recipe.errors.full_messages.join("\n")
        render :action => 'index'
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
    redirect_to :back
  end
end
