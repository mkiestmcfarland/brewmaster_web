class AddToCommandLog < ActiveRecord::Migration
  def change
    add_column :command_logs, :error_message, :text
    remove_column :brew_session_logs, :current_command
    add_column :brew_session_logs, :command_logs_id, :integer
  end
end
