class Item < ApplicationRecord
    default_scope { where(deleted_at: nil) }
    enum genre: { inactive: 0, active: 1 }

    def destroy
        update(deleted_at: Time.current)
     end 
end
