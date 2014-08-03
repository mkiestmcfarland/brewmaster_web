class Arduino
  def initialize
    @sp = Arduino.create_connection
  end

  def self.create_connection
    #params for serial port
    #@port_str = "/dev/ttyUSB0" #"/dev/tty.usbserial-A9007QGb"  #may be different for you
    #@port_str = "/dev/tty.usbserial-A9007QGb"  #may be different for you
    port_str = "/dev/tty.usbmodem1411"
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    return SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
  end

  def self.read
    begin
      sp = Arduino.create_connection
      Rails.logger.info('Connected to the Serial Port')
    rescue
      Rails.logger.info('Not able to connect to the Serial Port')
    end
    while (line = sp.readline) do
      split = line.split(',')
      if (line.index('Status') == 0) #standard logging
        #[function],[time since start],[current command],[free ram],[kettle temp],[wort pump on]
        elapsed_time = split[1]
        cmd = split[2].to_i
        ram = split[3]
        kettle_temp = split[4]
        wort_pump_on = split[5] == '1'
        #ram less than 100, throw fit
        BrewSessionLog.create(time_since_start: elapsed_time, command_logs_id: cmd, free_ram: ram,
                              kettle_degrees_fahrenheit: kettle_temp, wort_pump_on: wort_pump_on)
      else #command completed
        #[database command id],[status],[error message]
        command_id = split[0]
        status = split[1]
        c = CommandLog.find_by_id(command_id.to_i)
        if split.length > 2
          c.update_attributes(status: status, error_message: split[2])
        else
          c.update_attributes(status: status)
        end
      end
    end
  end

  def send_command(command, params='')
    cmd = CommandLog.create(command: command, parameters: params)
    command_string = "#{cmd.id},#{command}"
    command_string += ",#{params}" if params
    @sp.puts(command_string)
  end

  def heat_to(temp)
    send_command('heat to', "#{temp}")
  end

  def hold_at(temp, duration)
    send_command('hold at', "#{temp},#{duration}")
  end

  def fill(weight)
    send_command('fill', "#{weight}")
  end
  
  def grind(expected_weight)
    send_command('grind', "#{expected_weight}")
  end

  def pump(off=true)
    send_command('pump', "#{off}")
  end

  def chill (temp)
    send_command('chill', "#{temp}")
  end

  def recirculate_mash
    send_command('recirculate mash')
  end

  def whirlpool
    send_command('whirlpool')
  end

  def drain
    send_command('drain')
  end

  def lift_mash
    send_command('lift mash')
  end

  def dump_mash
    send_command('dump mash')
  end

  def CIP
    send_command('CIP')
  end

  def lid_up
    send_command('lid', 'up')
  end

  def lid_down
    send_command('lid', 'down')
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