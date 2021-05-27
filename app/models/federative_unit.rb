require 'active_record'

class FederativeUnit < ActiveRecord::Base
  has_many :city
end
