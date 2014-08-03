class BrewSessionLog < ActiveRecord::Base
  monetize :kettle_degrees_fahrenheit_cents
  belongs_to :command_log
end
