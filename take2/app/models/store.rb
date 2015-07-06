class Store < ActiveRecord::Base

  has_secure_password

  # need a workaround for this line or it'll spit out an error
  # SyntaxError: /app/models/store.rb:7: syntax error, unexpected '\n', expecting =>
  # before_validation :on => :create, :gen_api_token

  # validations
  validates :api_token,
            :uniqueness => true

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, confirmation: true

  # associations
  has_many :receipts, dependent: :destroy
  has_one :api_token, dependent: :destroy

  # returns store or false
  def self.confirm(params)
    store = Store.find_by(email: params[:email])
    store.try(:authenticate, params[:password])
  end

   def gen_api_token
      token = SecureRandom.uuid

      # run simple validation
      until StoreOwner.find_by(api_token: token).nil?
        token = SecureRandom.uuid
      end

      self.api_token = token
    end

end
