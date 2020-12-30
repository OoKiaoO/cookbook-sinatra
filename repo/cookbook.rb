require 'csv'
require_relative '../model/recipe'

class Cookbook
  attr_reader :recipes

  def initialize(csv_file_path)
    @recipes = []
    @filepath = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_recipe_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@filepath) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def save_csv
    CSV.open(@filepath, 'w') do |csv|
      @recipes.each do |element|
        csv << [element.name, element.description, element.rating, element.done, element.prep_time]
      end
    end
  end
end
