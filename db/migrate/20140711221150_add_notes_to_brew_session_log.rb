class AddNotesToBrewSessionLog < ActiveRecord::Migration
  def change
    add_column :brew_session_logs, :notes, :text
  end
end
