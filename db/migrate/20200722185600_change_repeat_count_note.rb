class ChangeRepeatCountNote < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    ObjectManager::Attribute.add(
      force:       true,
      object:      'Ticket',
      name:        'repeat_count',
      display:     'repeat count',  
      data_type:   'integer',
      data_option: {
        default:    0, 
        maxlength: 150,
        null:      true,
        note:      'The number of the same Azure signals fired',
        min:       0,
        max:       999_999_999,
      },
      editable:    false,
      active:      true,
      screens:     {
        create_middle: {},
        edit: {
         'ticket.customer' => {
            shown: true,                           
          },
           'ticket.agent' => {
             shown: true,
             },
         },    
      },
      to_create:   false,
      to_migrate:  false,
      to_delete:   false,
      position:    102,
      created_by_id: 1,
      updated_by_id: 1,
    )
    
  end
end
