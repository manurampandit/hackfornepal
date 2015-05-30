json.user do
  json.id @user.id
  json.name @user.user_name
  json.mobile @user.phone_no
  json.location @user.geoproperty
end
