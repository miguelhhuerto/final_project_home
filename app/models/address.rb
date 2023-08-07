class Address < ApplicationRecord
  enum genre: { home: 0, office: 1 }

  belongs_to :user
  belongs_to :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  belongs_to :province, class_name: 'Address::Province', foreign_key: 'address_province_id'
  belongs_to :city, class_name: 'Address::City', foreign_key: 'address_city_id'
  belongs_to :barangay, class_name: 'Address::Barangay', foreign_key: 'address_barangay_id'
  validate :single_default , if: :is_default_changed?
  validate :address_limit, on: :create
  private

  def single_default
    if user.addresses.where(is_default: true).where.not(id: id).exists?
      user.addresses.where.not(id: id).update(is_default: false)
    end
  end

  def address_limit
    if user.addresses.count >= 5
      errors.add(:base, "You can have a maximum of 5 addresses.")
    end
  end

end