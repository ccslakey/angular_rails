class StoreOwner < ActiveRecord::Base
	has_secure_password
	has_many :simpe_receipts
	before_validation :on => [:create, :gen_api_token]

	  validates :api_token,
	            :uniqueness => true

	  validates :email,
	            :presence => true,
	            :uniqueness => true


	  def gen_api_token
	    token = SecureRandom.uuid

	    # run simple validation
	    until StoreOwner.find_by(api_token: token).nil?
	      token = SecureRandom.uuid
	    end

	    self.api_token = token
	  end

	 def confirm_token(params)
    token = params[:api_token]
    store_owner = StoreOwner.find_by!(api_token: token)
  end
		
		def self.confirm(params)
			store_owner = self.find_by!(email: params[:email])
			store_owner. authenticate(params[:password])
		end

end
