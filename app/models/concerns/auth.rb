module Auth
  extend ActiveSupport::Concern

  included do
    has_secure_password
    validates :password, length: { minimum: 6 }
  end
end
