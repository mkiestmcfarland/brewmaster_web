class AddDefaultToStatus < ActiveRecord::Migration
  def change
    change_column :command_logs, :status, :string, :default => 'pending'
  end
end
