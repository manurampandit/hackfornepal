json.users do 
  json.array! @users do |user|
      json.id user.id
      json.name user.name
      json.distance user.distance
        json.geofeature do
           json.geoproperty user.lats
        end
    end
end
