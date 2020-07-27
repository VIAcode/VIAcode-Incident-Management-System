class RenameTicketHiddenTags < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    rename_column :tickets, :alert_target, :connector_data_1
    rename_column :tickets, :alert_monitoring_service, :connector_data_2
    
  end
end
