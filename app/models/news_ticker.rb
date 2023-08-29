class NewsTicker < ApplicationRecord
    belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
    enum status: { active: 0, inactive: 1 }
end
