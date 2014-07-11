class HardwaresController < ApplicationController
  def index
    render :new
  end

  def new
    @hardware = Hardware.new
  end

  def set_temp
    set_hardware
    if (@hardware.valid?)
      Arduino.new.heat_to(@hardware.temperature)
      flash[:notice] = "Temperature Set"
    else
      flash[:error] = "Illegal input"
    end
    render :new
  end

  def hold_at
    set_hardware
    if @hardware.valid?
      Arduino.new.hold_at(@hardware.temperature, @hardware.duration)
    end
    render :new
  end

  private
  def set_hardware
    @hardware = Hardware.new(params[:hardware])
  end
end
