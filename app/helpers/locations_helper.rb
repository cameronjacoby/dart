module LocationsHelper

  def location_matches
    {
      "austin" => /austin/i,
      "berkeley" => /berkeley/i,
      "boston" => /boston/i,
      "chicago" => /chicago/i,
      "denver" => /denver/i,
      "los-angeles" => /los angeles|\bla\b/i,
      "new-york" => /new york|\bny\b|\bnyc\b/i,
      "oakland" => /oakland/i,
      "palo-alto" => /palo alto/i,
      "philadelphia" => /philadelphia|philly/i,
      "portland" => /portland/i,
      "redwood-city" => /redwood city/i,
      "san-francisco" => /san francisco|\bsf\b/i,
      "san-jose" => /san jose/i,
      "seattle" => /seattle/i,
      "washington-dc" => /\bdc\b|\bd.c./i,
      "amsterdam" => /amsterdam/i,
      "berlin" => /berlin/i,
      "dublin" => /dublin/i,
      "london" => /london/i,
      "melbourne" => /melbourne/i,
      "shanghai" => /shanghai/i,
      "sydney" => /sydney/i,
      "tokyo" => /tokyo/i,
      "toronto" => /toronto/i,
      "vancouver" => /vancouver/i,
      "remote" => /remote/i
    }
  end

end