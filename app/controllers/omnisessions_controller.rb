class OmnisessionsController < ApplicationController
	def create
		auth = request.env['omniauth.auth']
		user = User.where(provider: auth['provider'],uid: auth['uid']).first || 
		User.create_with_ommniauth(auth)	
        
  		#Creacion de variable de session
		session[:user_id] = user.id
  		redirect_to root_path
	end
end