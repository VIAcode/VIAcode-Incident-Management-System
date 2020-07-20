class RenameTicketHiddenTags < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    rename_column :tickets, :alert_target, :hidden_tag_1
    rename_column :tickets, :alert_monitoring_service, :hidden_tag_2
    
  end
end
