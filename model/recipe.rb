class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :done

  def initialize(name, description, rating = 0, prep_time = 'N/A')
    @name = name
    @description = description
    @rating = rating
    @done = false
    @prep_time = prep_time
  end

  def mark_as_done!
    @done = true
  end
end
