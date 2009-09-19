# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def google_maps_key
    if request.host.match( /^www\.demowatch\.de/i)
      "ABQIAAAAbmKt_bX8rXoUBM2tWSorIRTnBMjsH0Y2aRb-_04glZphNt2GURSXRZg8NE723uvkLLIsOlfTgHhmzA"
    else
      "ABQIAAAAbmKt_bX8rXoUBM2tWSorIRRIprxYrvhzIftfk2H1NRSL0ylmFBQNgArCNLV3vVHVwuG4YfMtNHBR8Q"
    end
  end
end
