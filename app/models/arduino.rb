class Arduino
  def self.create_connection
    #params for serial port
    #@port_str = "/dev/ttyUSB0" #"/dev/tty.usbserial-A9007QGb"  #may be different for you
    #@port_str = "/dev/tty.usbserial-A9007QGb"  #may be different for you
    #port_str = "/dev/tty.usbmodem1411"
    baud_rate = 9600
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    return SerialPort.new(ARDUNIO_PORT, baud_rate, data_bits, stop_bits, parity)
  end

  def self.read
    begin
      sp = Arduino.create_connection
      Rails.logger.info('Connected to the Serial Port')
    rescue
      Rails.logger.info('Not able to connect to the Serial Port')
    end
    begin
      while (line = sp.readline) do
        Rails.logger.info(line)
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
          status = split[1].chomp
          c = CommandLog.find_by_id(command_id.to_i)
          if c.present?
            if split.length > 2
              c.update_attributes(status: status, error_message: split[2])
            else
              c.update_attributes(status: status)
            end
          end
        end
      end
    rescue => e
      Rails.logger.error(e.message)
    end
  end

  def self.send_command(command, params='')
    cmd = CommandLog.create(command: command, parameters: params)
    command_string = "#{cmd.id},#{command}"
    command_string += ",#{params}" if params
    sp = Arduino.create_connection
    sp.puts(command_string)
  end

  def self.heat_to(temp)
    send_command('heatTo', "#{temp}")
  end

  def self.boil(duration)
    send_command('boil', "#{duration}")
  end

  def self.fill(weight)
    send_command('fill', "#{weight}")
  end

  def self.grind(expected_weight)
    send_command('grind', "#{expected_weight}")
  end

  def self.hold_at(temp, duration)
    send_command('holdAt', "#{temp},#{duration}")
  end

  def self.whirlpool_valve(toggle='off')
    send_command('whirlpoolValve', "#{toggle}")
  end

  def self.wort_pipe_valve(toggle='off')
    send_command('wortPipeValve', "#{toggle}")
  end

  def self.wort_pump(toggle='off')
    send_command('wortPump', "#{toggle}")
  end

  def self.drain_valve(toggle='off')
    send_command('drainValve', "#{toggle}")
  end

  def self.cip_pump(toggle='off')
    send_command('CIPPump', "#{toggle}")
  end


  def self.chill (temp)
    send_command('chill', "#{temp}")
  end

  def self.recirculate_mash
    send_command('recirculate mash')
  end

  def self.whirlpool
    send_command('whirlpool')
  end

  def self.lift_mash
    send_command('lift mash')
  end

  def self.dump_mash
    send_command('dump mash')
  end

  def self.lid(up=false)
    send_command('lid', "#{up ? 'up' : 'down'}")
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