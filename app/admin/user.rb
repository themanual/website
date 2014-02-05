ActiveAdmin.register User do
  permit_params :name, :email, :access_level

end
