class SessionsController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :failed_login

	def new
	  @store_owner = StoreOwner.new
	end

	def create
	  @store_owner = StoreOwner.confirm(params)
	  login(@store_owner)
	  redirect_to "/account"
	end


	 def destroy
		logout
	end
	protected

	  def failed_login(e)
	    flash[:error] = "Failed Login"
	    redirect_to "/login"
	  end


end
