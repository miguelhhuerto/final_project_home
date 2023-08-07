class Parent < User
    has_many :users, :class_name => 'Parent', :foreign_key => :parent_id
end