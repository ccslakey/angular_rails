module SessionsHelper

	def login(store_owner)
	  session[:owner_id] = store_owner.id
	  @current_owner = store_owner
	end

	def logout
	  @current_owner = session[:owner_id] = nil
	end

	def current_owner
	  @current_owner ||= StoreOwner.find_by(id: session[:owner_id])
	end

	def logged_in?
	  !current_owner.nil?
	end

	def require_login
	  if !logged_in?
	    redirect_to "/login"
	  end
	end

	def logout (current_owner)
		current_owner = session[:user_id] = nil
	end
	
end
