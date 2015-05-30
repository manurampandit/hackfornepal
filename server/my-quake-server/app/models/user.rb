class User < ActiveRecord::Base
	self.primary_key = "id"   
  	self.rgeo_factory_generator = RGeo::Geos.method(:factory)
  	set_rgeo_factory_for_column(:geoproperty, RGeo::Geographic.spherical_factory)

  	# attr_accessible :user_name, :phone_no, :geoproperty
end
