class BrewSessionLogsController < ApplicationController
  before_action :set_safe_params, :only => [:create]
  before_action :set_brew_log, :only => [:new, :create]
  before_action :get_logs, :only => [:index, :index_table]

  def index
  end

  def index_table
    render :partial => '/brew_session_logs/table', :locals => {:brew_session_logs => @brew_session_logs},
                     :content_type => 'text/html', :layout => false
  end

  def new
  end

  def create
    if @brew_log.save
      flash[:notice] = "Note Created"
    end
    redirect_to  brew_session_logs_path
  end

  private
  def set_brew_log
    @brew_log = BrewSessionLog.new(params[:brew_session_log])
  end

  def get_logs
    @brew_session_logs = BrewSessionLog.all.order(:created_at)
  end

  def set_safe_params
    params[:brew_session_log] = params.require(:brew_session_log).permit(:notes)
  end
end
