class BrewSessionLog < ActiveRecord::Base
  monetize :degrees_fahrenheit_cents
end
