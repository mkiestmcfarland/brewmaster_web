class HardwaresController < ApplicationController
  def set_temp
    if check_numeric_param(:temperature)
      Arduino.heat_to(params[:temperature])
      flash[:notice] = "Temperature set to: #{params[:temperature]}."
    else
      flash[:error] = "Illegal input"
    end
    render :index
  end

  def hold_at
    if check_numeric_param(:temperature) && check_numeric_param(:duration)
      Arduino.hold_at(params[:temperature], params[:duration])
      flash[:notice] = "Temperature set to: #{params[:temperature]} for #{params[:duration]} min."
    else
      flash[:error] = "Illegal input"
    end
    render :index
  end

  def boil
    if check_numeric_param(:duration)
      Arduino.boil(params[:duration])
      flash[:notice] = "Boil duration set to: #{params[:duration]} min."
    else
      flash[:error] = "Illegal input"
    end
    render :index
  end

  def grind
    if check_numeric_param(:weight)
      Arduino.grind(params[:weight])
      flash[:notice] = "Grind set to: #{params[:weight]} oz."
    end
    render :index
  end

  def fill
    if check_numeric_param(:weight)
      Arduino.fill(params[:weight])
      flash[:notice] = "Fill set to: #{params[:weight]} oz."
    end
    render :index
  end

  def whirlpool_valve
    if check_toggle_param
      Arduino.whirlpool_valve(params[:toggle])
      flash[:notice] = "Whirlpool valve set to: #{params[:toggle]}"
    end
    render :index
  end

  def wort_pipe_valve
    if check_toggle_param
      Arduino.wort_pipe_valve(params[:toggle])
      flash[:notice] = "Wort pipe valve set to: #{params[:toggle]}"
    end
    render :index
  end

  def wort_pump
    if check_toggle_param
      Arduino.wort_pump(params[:toggle])
      flash[:notice] = "Wort pump set to: #{params[:toggle]}"
    end
    render :index
  end

  def drain_valve
    if check_toggle_param
      Arduino.drain_valve(params[:toggle])
      flash[:notice] = "Drain valve set to: #{params[:toggle]}"
    end
    render :index
  end

  def cip_pump
    if check_toggle_param
      Arduino.cip_pump(params[:toggle])
      flash[:notice] = "CIP pump set to: #{params[:toggle]}"
    end
    render :index
  end
  
  private
    def check_toggle_param
      if (!params[:toggle] || (params[:toggle] != 'off' && params[:toggle] != 'on'))
        flash[:error] = "Illegal input"
        return false
      end
      return true
    end

  def check_numeric_param(param)
    if (!params[param] || params[:param].to_i != 0)
      flash[:error] = "Illegal input"
      return false
    end
    return true
  end
end
