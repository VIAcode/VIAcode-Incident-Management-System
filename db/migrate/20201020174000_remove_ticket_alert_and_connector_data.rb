class RemoveTicketAlertAndConnectorData < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    remove_column :tickets, :alert
    remove_column :tickets, :connector_data_1
    remove_column :tickets, :connector_data_2
    
  end
end
