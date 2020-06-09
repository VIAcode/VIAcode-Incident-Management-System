class AddAspectField < ActiveRecord::Migration[5.1]
  def up

    # return if it's a new setup
    return if !Setting.find_by(name: 'system_init_done')

    add_column :tickets, :aspect,   :string, limit: 250, null: false, default: ''

    ObjectManager::Attribute.add(
      force:       true,
      object:      'Ticket',
      name:        'aspect',
      display:     'Aspect',
      data_type:   'select',
      data_option: {
        default:    '',
        options:    {
          'Cost'        => 'Cost',
          'Security'    => 'Security',
          'Monitoring'  => 'Monitoring',
          'Other'       => 'Other',
        },
        nulloption: true,
        multiple:   false,
        null:       true,
        translate:  true,
      },
      editable:    true,
      active:      true,
      screens:     {
        create_middle: {},
        edit:          {
          '-all-' => {
            shown: true,
          },
        },
      },
      to_create:   false,
      to_migrate:  false,
      to_delete:   false,
      position:    2000,
    )

  end
end
