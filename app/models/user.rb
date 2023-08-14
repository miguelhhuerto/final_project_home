class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_param
    username
  end

  enum role: { client: 0, admin: 1 }
  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
    }
  validates :username, presence: true, uniqueness: { case_sensitive: false }


  has_one :profile
  has_many :addresses
  has_many :bets
  has_many :offers
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id', dependent: :nullify
  accepts_nested_attributes_for :profile
  mount_uploader :image, ImageUploader

end
