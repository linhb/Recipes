module RecipesHelper
  def prettify(contents)
    parsed = contents.match(/(.+?)\r\n(.+)/m)
    name = parsed[1] if parsed
    instructions = parsed[2] if parsed
    "<div class='recipe_name'>
      #{name.titleize}
    </div>
    #{instructions.gsub(/\r\n/, '<br />')}"
  end
end
