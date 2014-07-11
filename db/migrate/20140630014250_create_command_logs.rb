class CreateCommandLogs < ActiveRecord::Migration
  def change
    create_table :command_logs do |t|
      t.string :command
      t.text :parameters
      t.string :status
      t.timestamps
    end
  end
end
