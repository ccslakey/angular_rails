class StoreOwnersController < ApplicationController

		before_action :require_login, only: [:show, :reset_token]
		rescue_from ActiveRecord::RecordInvalid, with: :invalid_signup

		## add this to before_action list
		def token_reset
		  current_owner.gen_api_token
		  current_owner.save
		  redirect_to "/account"
		end

		def new
		  @store_owner = StoreOwner.new
		end

		def create
		  @store_owner = StoreOwner.create!(owner_params)
		  login(@store_owner)
		  redirect_to "/account"
		end

		def show
		  @store_owner = current_owner
		  respond_to do |f|
		      f.html
		      f.json {render json: @store_owner }
		    end
		end

		protected

		  def invalid_signup(e)
		    flash[:error]= e.message
		    redirect_to "/signup"
		  end

		private

		  def owner_params
		    params.require(:store_owner).permit(:name, :email, :password, :password_digest)
		  end


end
