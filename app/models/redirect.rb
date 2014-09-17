class Redirect < ActiveRecord::Base
  validate :from, :to, presence: true
end
