class Admin < User

  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id',
                           inverse_of: :author, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
end
