class Banner < ApplicationRecord
  enum status: { active: 0, inactive: 1 }
  mount_uploader :preview, ImageUploader
end
