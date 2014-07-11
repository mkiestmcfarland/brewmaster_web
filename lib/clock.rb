require 'rubygems'
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'ardunio_read_job'
require 'clockwork'

include Clockwork

every(10.seconds, 'ardunio.read') { Delayed::Job.enqueue ArdunioReadJob.new }