class Arduino
  #params for serial port
  @port_str = "/dev/tty.usbserial-A9007QGb"#"/dev/ttyUSB0"  #may be different for you
  @baud_rate = 9600
  @data_bits = 8
  @stop_bits = 1
  @parity = SerialPort::NONE

  def initialize
    @sp = SerialPort.new(@port_str, @baud_rate, @data_bits, @stop_bits, @parity)
  end

  def read
    r = @sp.gets.chomp
    Delayed::Worker.logger.add(Logger::INFO, r)
    #BrewSessionLog.create(:degrees_fahrenheit => 1)
  end

  def fill(weight)
    #(success)
  end
  
  def grind(expected_weight)
    #(actual added weight)
  end

  def heat_to(temp) #(success)
    cmd = CommandLog.create(:command => "heat_to", :parameters => {:temp => temp})
    @sp.puts(temp, cmd.id)
  end

  def hold_at(temp, duration) (success)
    cmd = CommandLog.create(:command => "heat_to", :parameters => {:temp => temp, :duration => duration})
    @sp.puts(temp, duration, cmd.id)
  end

  def recirculate_mash (success)
  end

  def whirlpool (success)
  end

  def drain (success)

  end

  def pump_off (success)
  end

  def chill (temp) (success)
  end

  def lift_mash (success)
  end

  def dump_mash (success)
  end

  def CIP (success)
  end

  def lid_up (success)
  end

  def lid_down (success)
  end
end
##params for serial port
#port_str = "/dev/tty.usbserial-A9007QGb"#"/dev/ttyUSB0"  #may be different for you
#baud_rate = 9600
#data_bits = 8
#stop_bits = 1
#parity = SerialPort::NONE
#
#sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
#sp.puts('111,')
##just read forever
#while true do
#  while (i = sp.gets.chomp) do       # see note 2
#    puts i                                            #puts i.class #String
#  end
#end
#
#sp.close                       #see note 1