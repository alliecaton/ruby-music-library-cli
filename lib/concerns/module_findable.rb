require 'pry'

module Concerns

  module Findable

        def find_by_name(name)
            self.all.find do |x|
                x.name == name 
            end 
        end 

        def self.find_or_create_by_name(name)
            if find_by_name(name) != nil
              find_by_name(name)
            else
              self.create(name)
            end
        end
    
      end 


end 
