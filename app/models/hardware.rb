class Hardware
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Model
  extend ActiveModel::Naming

  validates :temperature, :numericality => true
  validates :duration, :numericality => true, :allow_nil => true

  attr_accessor :temperature, :duration

end