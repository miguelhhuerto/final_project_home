module Address
  def self.table_name_prefix
    "address_"
  end
end

class Address < ApplicationRecord
  belongs_to :user
end

