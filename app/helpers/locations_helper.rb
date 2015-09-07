module LocationsHelper

  def location_matches
    {
      "austin" => /\baustin\b/i,
      "boston" => /\bboston\b/i,
      "chicago" => /\bchicago\b/i,
      "new-york" => /\bnew york\b|\bny\b|\bnyc\b/i,
      "palo-alto" => /\bpalo alto\b/i,
      "philadelphia" => /\bphiladelphia\b|\bphilly\b/i,
      "portland" => /\bportland\b/i,
      "redwood-city" => /\bredwood city\b/i,
      "san-francisco" => /\bsan francisco\b|\bsf\b/i,
      "san-jose" => /\bsan jose\b/i,
      "seattle" => /\bseattle\b/i,
      "washington-dc" => /\bdc\b|\bd.c./i,
      "amsterdam" => /\bamsterdam\b/i,
      "berlin" => /\bberlin\b/i,
      "dublin" => /\bdublin\b/i,
      "london" => /\blondon\b/i,
      "melbourne" => /\bmelbourne\b/i,
      "shanghai" => /\bshanghai\b/i,
      "sydney" => /\bsydney\b/i,
      "tokyo" => /\btokyo\b/i,
      "toronto" => /\btoronto\b/i,
      "vancouver" => /\bvancouver\b/i,
      "remote" => /\bremote\b/i
    }
  end

end