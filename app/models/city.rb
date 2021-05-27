require 'active_record'

class City < ActiveRecord::Base
  belongs_to :federative_unit
end
