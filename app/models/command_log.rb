class CommandLog < ActiveRecord::Base
  serialize :parameters
end
