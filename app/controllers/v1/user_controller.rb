class V1::UserController < ApplicationController
	skip_before_action :verify_authenticity_token

	def login
		user = User.where(email: params[:email]).first
	      
		if user&.valid_password?(params[:password])
		  	render json: user.as_json(only:[:email,:first_name,:last_name,:phone,:authentication_token]), status: :created
		else
		  	head(:unauthorized)
		end
	end


	def signup
		user = User.new(usr_params)

		if user.save
		    render json: {status: 'success', data:user}, status: :ok
		else
		    render json: {status: 'error', message:'There was some error in registering the user.', data:user.errors}, status: :unprocessable_entity
		end
	end


	private 

	def usr_params
		params.permit(:email,:password,:phone,:first_name,:last_name)
	end

end
