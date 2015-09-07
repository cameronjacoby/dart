module CategoriesHelper

  def category_matches
    {
      "back-end" => /back end|back-end|backend/i,
      "front-end" => /front end|front-end|frontend/i,
      "full-stack" => /full stack|full-stack|fullstack/i,
      "android" => /android/i,
      "ios" => /\bios\b/i,
      "design" => /\bdesigner\b/i
    }
  end

end