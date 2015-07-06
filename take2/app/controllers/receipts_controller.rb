class ReceiptsController < ApplicationController

  before_action :require_token
  rescue_from ActiveRecord::RecordNotFound, with: :bad_token
  respond_to :html, :json

    def index
    @receipts = current_store.receipts
    respond_to do |f|
      f.json { render json: @receipts }
    end
  end

  #
  # GET /receipts.json
  #
  def show
    if current_store.api_token
      @receipts = current_store.receipts
      respond_with @receipts
    else
      # unauthorized
      render json: { status:"error",
                       mesg:"Invalid API token" }, status: 401
    end
  end

  #
  # POST /receipts.json
  #
  def create
    if current_store.api_token
      @receipt = current_store.Receipt.create receipt_params
      # Make sure there's a receipt_path in routes.rb
      # The responder will look for a receipt_path even though it's
      # not actually redirecting (as in the case of JSON response)
      respond_with @receipt
      # equivalent to:
      # respond_to do |format|
      #   if @receipt.save
      #     format.json { render json: @receipt, location: receipt_path }
      #   else
      #     format.json { render json: @receipt.errors, status: :unprocessable_entity }
      #   end
      # end
    else
      # unauthorized
      render json: { status:"error",
                       mesg:"Invalid API token" }, status: 401
    end
  end


  protected

    def bad_token(e)
      render json: { status: 401,  errors: e.message }, status: 401
    end


  private

  def validate_api_token
    @api_token = ApiToken.find_by hex_value:params[:api_token]
  end

  def receipt_params
    # permit all receipt attributes
    # maybe not secure, but not typing everying out
    # TODO: a better way?
    params.require(:receipt).permit!
  end

end
