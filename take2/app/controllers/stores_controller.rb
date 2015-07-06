class StoresController < ApplicationController

  before_action :require_login, only: [:show, :reset_token]
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_signup

  #
  # GET /signup
  #
  def new
    @store = Store.new
  end

  #
  # GET /account/:id
  #
  def show
    @store = Store.find params[:id]
  end

  #
  # POST /stores
  #
  def create
    @store = Store.new store_params
    if @store.save
      # line 27 => to change
      @store.gen_api_token
      login @store
      redirect_to account_path @store
    else
      render :new
    end
  end

  def passwd_reset
    # can only get here through login form
    # can't go here if logged in
  end

  # login required for this
  def token_reset
    current_owner.gen_api_token
    current_owner.save
    redirect_to "/account"
  end

  protected

    def invalid_signup(e)
      flash[:error]= e.message
      redirect_to "/signup"
    end

  private

  def store_params
    params.require(:store).permit(:name, :email, :email_confirmation, :password, :password_confirmation)
  end

  def assign_api_token store
    # TODO: handle uniqueness validation failure
    @api_token = ApiToken.create(store_id:store.id, hex_value:SecureRandom.hex)
  end

end
