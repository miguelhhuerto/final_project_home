class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
  accepts_nested_attributes_for :profile
  mount_uploader :image, ImageUploader
end
