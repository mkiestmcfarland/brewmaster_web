class CreateBrewSessionLogs < ActiveRecord::Migration
  def change
    create_table :brew_session_logs do |t|
      t.money :degrees_fahrenheit #two decimal places
      t.timestamps
    end
  end
end
