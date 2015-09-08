module RolesHelper

  def role_matches
    {
      "back-end" => /back end|back-end|backend/i,
      "front-end" => /front end|front-end|frontend/i,
      "full-stack" => /full stack|full-stack|fullstack/i,
      "dev-ops" => /dev ops|devops/i,
      "android" => /android/i,
      "ios" => /\bios\b/i,
      "designer" => /\bdesigner\b/i
    }
  end

end