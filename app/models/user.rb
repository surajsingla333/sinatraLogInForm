class User < ActiveRecord::Base    
    validates :Username, uniqueness: true 
end