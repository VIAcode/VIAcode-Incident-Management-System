class HideExternalWiId < ActiveRecord::Migration[5.1]
    def up
  
      # return if it's a new setup
      return if !Setting.find_by(name: 'system_init_done')

      ObjectManager::Attribute.add(
        force:       true,
        object:      'Ticket',
        name:        'external_ticket_id',
        display:     'External ticket id',  
        data_type:   'input',
        data_option: {
            default:    '', 
            maxlength: 150,
            null:      true,
            type:      'text'
        },
        editable:    false,
        active:      true,
        screens:     {
            create_middle: {},
            edit: {
              '-all-' => {
                shown: false,
              },
            }    
        },
        to_create:   false,
        to_migrate:  false,
        to_delete:   false,
        position:    104,  
        created_by_id: 1,
        updated_by_id: 1,
      )
    end
end
