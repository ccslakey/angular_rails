class SimpleReceiptsController < ApplicationController
	before_action :require_token
	rescue_from ActiveRecord::RecordNotFound, with: :bad_token


	# view all receipts at
	#   localhost:3000/simple_receipts?api_token=YOUR_TOKEN
	def index
	  @receipts = current_owner.simple_receipts
	  respond_to do |f|
	    f.json { render json: @receipts }
	  end
	end

	def create
	  @receipt = current_owner.simple_receipts.create(receipt_params)
	  respond_to do |f|
	    f.json { render json: @receipt }
	  end
	end



	protected

	  def bad_token(e)
	    render json: { status: 401,  errors: e.message }, status: 401
	  end
	  
	private

	  def require_token
	    api_token = params[:api_token]
	    @current_owner = StoreOwner.find_by!(api_token: api_token)
	  end

	  def receipt_params
	    params.require(:receipt).permit(:transaction_num, :total, :amount, :tip)
	  end



end
