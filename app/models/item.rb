class Item < ApplicationRecord
    belongs_to :user
    default_scope { where(deleted_at: nil) }

    def destroy
        update(deleted_at: Time.current)
     end 
end
