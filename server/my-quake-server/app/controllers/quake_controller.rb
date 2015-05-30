class QuakeController < ApplicationController

  def create
    begin
      user = User.new
      user.user_name = params[:name]
      user.phone_no = params[:phone_no]
      lat = params[:lat]
      lon = params[:lon]
      user.utype = params[:utype]
      user.need = params[:need]
      user.disaster = params[:disaster]
      user.geoproperty = "POINT(#{lat} #{lon})"
      user.save
      render json: {"Message" => "User created"}, status: 200
    rescue
      render json: {"error" => "User not found"}, status: 404
    end
  end

  def show
  	if (params[:utype] == 1)
    	begin
      		@user = User.where("utype = 1")
    	rescue
      		render json: {"error" => "User not found"}, status: 404
    	end
    elsif (params[:utype] == 2)
    	begin
      		@user = User.where("utype = 2")
    	rescue
      		render json: {"error" => "User not found"}, status: 404
    	end
    else
    	begin
      		@user = User.find(params[:id])
    	rescue
      		render json: {"error" => "User not found"}, status: 404
    	end  
    end  		
  end

  def get_users
    	lat = params[:lon]
    	lon = params[:lat]
    	s_dist = params[:start_dist]
    	e_dist = params[:end_dist]

    	@users = User.find_by_sql("select id,name,distance,lats from(select id,user_name as name,AsText(geoproperty) as lats,(1.60934 * 3959 * acos(cos(radians(#{lat})) * cos(radians(y(geoproperty))) * cos(radians(x(geoproperty)) - radians(#{lon}))+ sin(radians(#{lat})) * sin(radians(y(geoproperty))))) as distance from users having distance > #{s_dist} and distance < #{e_dist})s order by s.distance;")
  end

  def random_quake
    magnitude = rand (5.0)..(9.0)
    @magnitude = magnitude.round(2)
    @distance = rand 1..3
    g_array = ["12.923591,77.593861","12.958725,77.697544","12.964078,77.594204","12.970435,77.528286","12.998871,77.601414","13.002216,77.562618","13.019611,77.59798","13.028642,77.662182","12.916564,77.549229","12.988835,77.549572","13.035331,77.596264","13.027973,77.539272"]
    index = rand 0..11
    co_ordinates = g_array[index]
    co_ords = co_ordinates.split(",")
    @lat = co_ords.first
    @lon = co_ords.last
  end


  private

  def person_params
    params.require(:user).permit(:id, :user_name, :phone_no, :geoproperty,:need, :type, :disaster, :urgency)
  end

  def near_user

  end


end
