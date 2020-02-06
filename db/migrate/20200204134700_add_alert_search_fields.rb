class AddAlertSearchFields < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    add_column :tickets, :alert_target, :string, null: true
    add_column :tickets, :alert_monitoring_service, :string, limit: 1000, null: true
    
  end
end
