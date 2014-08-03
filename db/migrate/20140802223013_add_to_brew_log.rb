class AddToBrewLog < ActiveRecord::Migration
  def change
    add_column :brew_session_logs, :time_since_start, :integer
    add_column :brew_session_logs, :current_command, :string
    add_column :brew_session_logs, :free_ram, :integer
    add_column :brew_session_logs, :wort_pump_on, :boolean
    rename_column :brew_session_logs, :degrees_fahrenheit_cents, :kettle_degrees_fahrenheit_cents
    rename_column :brew_session_logs, :degrees_fahrenheit_currency, :kettle_degrees_fahrenheit_currency
  end
end
