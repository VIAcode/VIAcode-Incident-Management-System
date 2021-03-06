ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'title',
  display:     'Title',
  data_type:   'input',
  data_option: {
    type:      'text',
    maxlength: 200,
    null:      false,
    translate: false,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_top: {
      '-all-' => {
        null: false,
      },
    },
    edit:       {},
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    15,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'customer_id',
  display:     'Customer',
  data_type:   'user_autocompletion',
  data_option: {
    relation:       'User',
    autocapitalize: false,
    multiple:       false,
    guess:          true,
    null:           false,
    limit:          200,
    placeholder:    'Enter Person or Organization/Company',
    minLengt:       2,
    translate:      false,
    permission:     ['ticket.agent'],
  },
  editable:    false,
  active:      true,
  screens:     {
    create_top: {
      '-all-' => {
        null: false,
      },
    },
    edit:       {},
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    10,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'type',
  display:     'Type',
  data_type:   'select',
  data_option: {
    default:    '',
    options:    {
      'Incident'           => 'Incident',
      'Problem'            => 'Problem',
      'Request for Change' => 'Request for Change',
    },
    nulloption: true,
    multiple:   false,
    null:       true,
    translate:  true,
  },
  editable:    true,
  active:      false,
  screens:     {
    create_middle: {
      '-all-' => {
        null:       false,
        item_class: 'column',
      },
    },
    edit:          {
      'ticket.agent' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    20,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'group_id',
  display:     'Group',
  data_type:   'select',
  data_option: {
    default:                  '',
    relation:                 'Group',
    relation_condition:       { access: 'full' },
    nulloption:               true,
    multiple:                 false,
    null:                     false,
    translate:                false,
    only_shown_if_selectable: true,
    permission:               ['ticket.agent', 'ticket.customer'],
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        null:       false,
        item_class: 'column',
      },
    },
    edit:          {
      'ticket.agent' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    25,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'owner_id',
  display:     'Owner',
  data_type:   'select',
  data_option: {
    default:            '',
    relation:           'User',
    relation_condition: { roles: 'Agent (SRE)' },
    nulloption:         true,
    multiple:           false,
    null:               true,
    translate:          false,
    permission:         ['ticket.agent'],
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        null:       true,
        item_class: 'column',
      },
    },
    edit:          {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    30,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'state_id',
  display:     'State',
  data_type:   'select',
  data_option: {
    relation:   'TicketState',
    nulloption: true,
    multiple:   false,
    null:       false,
    default:    Ticket::State.find_by(default_follow_up: true).id,
    translate:  true,
    filter:     Ticket::State.by_category(:viewable).pluck(:id),
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {
      'ticket.agent'    => {
        null:       false,
        item_class: 'column',
        filter:     Ticket::State.by_category(:viewable_agent_new).pluck(:id),
      },
      'ticket.customer' => {
        item_class: 'column',
        nulloption: false,
        null:       true,
        filter:     Ticket::State.by_category(:viewable_customer_new).pluck(:id),
        default:    Ticket::State.find_by(default_create: true).id,
      },
    },
    edit:          {
      'ticket.agent'    => {
        nulloption: false,
        null:       false,
        filter:     Ticket::State.by_category(:viewable_agent_edit).pluck(:id),
      },
      'ticket.customer' => {
        nulloption: false,
        null:       true,
        filter:     Ticket::State.by_category(:viewable_customer_edit).pluck(:id),
        default:    Ticket::State.find_by(default_follow_up: true).id,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    40,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'pending_time',
  display:     'Pending till',
  data_type:   'datetime',
  data_option: {
    future:      true,
    past:        false,
    diff:        24,
    null:        true,
    translate:   true,
    required_if: {
      state_id: Ticket::State.by_category(:pending).pluck(:id),
    },
    shown_if:    {
      state_id: Ticket::State.by_category(:pending).pluck(:id),
    },
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        null:       false,
        item_class: 'column',
      },
    },
    edit:          {
      '-all-' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    41,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'priority_id',
  display:     'Priority',
  data_type:   'select',
  data_option: {
    relation:   'TicketPriority',
    nulloption: false,
    multiple:   false,
    null:       false,
    default:    Ticket::Priority.find_by(default_create: true).id,
    translate:  true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {
      'ticket.agent' => {
        null:       false,
        item_class: 'column',
      },
    },
    edit:          {
      'ticket.agent' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    80,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'tags',
  display:     'Tags',
  data_type:   'tag',
  data_option: {
    type:      'text',
    null:      true,
    translate: false,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_bottom: {
      'ticket.agent' => {
        null: true,
      },
    },
    edit:          {},
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    900,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'alert',
  display:     'alert',
  data_type:   'input',
  data_option: {
    default:    '',
    type:      'text',
    maxlength: 2000,
    null:      true,
    translate: false,
  },
  editable:    false,
  active:      true,
  screens: {
    create_middle: {},
    edit: {},
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    101,
)

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
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'delegated_link',
  display:     'Delegated Request Link',
  data_type:   'input',
  data_option: {
    type:       'text',
    default:    '',
    null:      true,
    maxlength: 250,
  },
  editable:    false,
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
  position:    103,
)

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
)



ObjectManager::Attribute.add(
  force:       true,
  object:      'TicketArticle',
  name:        'type_id',
  display:     'Type',
  data_type:   'select',
  data_option: {
    relation:   'TicketArticleType',
    nulloption: false,
    multiple:   false,
    null:       false,
    default:    Ticket::Article::Type.lookup(name: 'note').id,
    translate:  true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {},
    edit:          {
      'ticket.agent' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    100,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'TicketArticle',
  name:        'internal',
  display:     'Visibility',
  data_type:   'select',
  data_option: {
    options:    {
      true:  'internal',
      false: 'public'
    },
    nulloption: false,
    multiple:   false,
    null:       true,
    default:    false,
    translate:  true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {},
    edit:          {
      'ticket.agent' => {
        null: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    200,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'TicketArticle',
  name:        'to',
  display:     'To',
  data_type:   'input',
  data_option: {
    type:      'text',
    maxlength: 1000,
    null:      true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_middle: {},
    edit:          {
      'ticket.agent' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    300,
)
ObjectManager::Attribute.add(
  force:       true,
  object:      'TicketArticle',
  name:        'cc',
  display:     'Cc',
  data_type:   'input',
  data_option: {
    type:      'text',
    maxlength: 1000,
    null:      true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_top:    {},
    create_middle: {},
    edit:          {
      'ticket.agent' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    400,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'TicketArticle',
  name:        'body',
  display:     'Text',
  data_type:   'richtext',
  data_option: {
    type:      'richtext',
    maxlength: 150_000,
    upload:    true,
    rows:      8,
    null:      true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create_top: {
      '-all-' => {
        null: false,
      },
    },
    edit:       {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    600,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'login',
  display:     'Login',
  data_type:   'input',
  data_option: {
    type:           'text',
    maxlength:      100,
    null:           true,
    autocapitalize: false,
    item_class:     'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {},
    view:            {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    100,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'firstname',
  display:     'Firstname',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       false,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {
      '-all-' => {
        null: false,
      },
    },
    invite_agent:    {
      '-all-' => {
        null: false,
      },
    },
    invite_customer: {
      '-all-' => {
        null: false,
      },
    },
    edit:            {
      '-all-' => {
        null: false,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    200,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'lastname',
  display:     'Lastname',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       false,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {
      '-all-' => {
        null: false,
      },
    },
    invite_agent:    {
      '-all-' => {
        null: false,
      },
    },
    invite_customer: {
      '-all-' => {
        null: false,
      },
    },
    edit:            {
      '-all-' => {
        null: false,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    300,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'email',
  display:     'Email',
  data_type:   'input',
  data_option: {
    type:       'email',
    maxlength:  150,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {
      '-all-' => {
        null: false,
      },
    },
    invite_agent:    {
      '-all-' => {
        null: false,
      },
    },
    invite_customer: {
      '-all-' => {
        null: false,
      },
    },
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    400,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'web',
  display:     'Web',
  data_type:   'input',
  data_option: {
    type:       'url',
    maxlength:  250,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    500,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'phone',
  display:     'Phone',
  data_type:   'input',
  data_option: {
    type:       'tel',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    600,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'mobile',
  display:     'Mobile',
  data_type:   'input',
  data_option: {
    type:       'tel',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    700,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'fax',
  display:     'Fax',
  data_type:   'input',
  data_option: {
    type:       'tel',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    800,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'organization_id',
  display:     'Organization',
  data_type:   'autocompletion_ajax',
  data_option: {
    multiple:   false,
    nulloption: true,
    null:       true,
    relation:   'Organization',
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {
      '-all-' => {
        null: true,
      },
    },
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    900,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'department',
  display:     'Department',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  200,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    true,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1000,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'street',
  display:     'Street',
  data_type:   'input',
  data_option: {
    type:      'text',
    maxlength: 100,
    null:      true,
  },
  editable:    true,
  active:      false,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1100,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'zip',
  display:     'Zip',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    true,
  active:      false,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1200,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'city',
  display:     'City',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    true,
  active:      false,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1300,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'country',
  display:     'Country',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  100,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    true,
  active:      false,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1325,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'address',
  display:     'Address',
  data_type:   'textarea',
  data_option: {
    type:       'text',
    maxlength:  500,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    true,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1350,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'password',
  display:     'Password',
  data_type:   'input',
  data_option: {
    type:         'password',
    maxlength:    100,
    null:         true,
    autocomplete: 'new-password',
    item_class:   'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {
      '-all-' => {
        null: false,
      },
    },
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      'admin.user' => {
        null: true,
      },
    },
    view:            {}
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1400,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'vip',
  display:     'VIP',
  data_type:   'boolean',
  data_option: {
    null:       true,
    default:    false,
    item_class: 'formGroup--halfSize',
    options:    {
      false: 'no',
      true:  'yes',
    },
    translate:  true,
    permission: ['admin.user', 'ticket.agent'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: true,
      },
    },
    view: {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1490,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'note',
  display:     'Note',
  data_type:   'richtext',
  data_option: {
    type:      'text',
    maxlength: 5000,
    null:      true,
    note:      'Notes are visible to agents only, never to customers.',
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {
      '-all-' => {
        null: true,
      },
    },
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1500,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'role_ids',
  display:     'Permissions',
  data_type:   'user_permission',
  data_option: {
    null:       false,
    item_class: 'checkbox',
    permission: ['admin.user'],
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {
      '-all-' => {
        null:    false,
        default: [Role.lookup(name: 'Agent (SRE)').id],
      },
    },
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: true,
      },
    },
    view:            {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1600,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'User',
  name:        'active',
  display:     'Active',
  data_type:   'active',
  data_option: {
    null:       true,
    default:    true,
    permission: ['admin.user', 'ticket.agent'],
  },
  editable:    false,
  active:      true,
  screens:     {
    signup:          {},
    invite_agent:    {},
    invite_customer: {},
    edit:            {
      '-all-' => {
        null: false,
      },
    },
    view:            {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1800,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'name',
  display:     'Name',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       false,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    200,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'shared',
  display:     'Shared organization',
  data_type:   'boolean',
  data_option: {
    null:       true,
    default:    true,
    note:       'Customers in the organization can view each other items.',
    item_class: 'formGroup--halfSize',
    options:    {
      true:  'yes',
      false: 'no',
    },
    translate:  true,
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1400,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'domain_assignment',
  display:     'Domain based assignment',
  data_type:   'boolean',
  data_option: {
    null:       true,
    default:    false,
    note:       'Assign Users based on users domain.',
    item_class: 'formGroup--halfSize',
    options:    {
      true:  'yes',
      false: 'no',
    },
    translate:  true,
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1410,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'domain',
  display:     'Domain',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       true,
    item_class: 'formGroup--halfSize',
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: true,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1420,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'note',
  display:     'Note',
  data_type:   'richtext',
  data_option: {
    type:      'text',
    maxlength: 5000,
    null:      true,
    note:      'Notes are visible to agents only, never to customers.',
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: true,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1500,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'azuredevops_organization',
  display:     'Azure DevOps Organization',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       true,
    item_class: 'formGroup--halfSize',
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1551,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'azuredevops_project',
  display:     'Azure DevOps Project',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  150,
    null:       true,
    item_class: 'formGroup--halfSize',
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1552,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'azuredevops_area',
  display:     'Azure DevOps Area',
  data_type:   'input',
  data_option: {
    type:       'text',
    maxlength:  250,
    null:       true,
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1553,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'azuredevops_token',
  display:     'Azure DevOps Token',
  data_type:   'input',
  data_option: {
    type:       'password',
    maxlength:  150,
    null:       true,
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1554,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Organization',
  name:        'active',
  display:     'Active',
  data_type:   'active',
  data_option: {
    null:       true,
    default:    true,
    permission: ['admin.organization'],
  },
  editable:    false,
  active:      true,
  screens:     {
    edit: {
      '-all-' => {
        null: false,
      },
    },
    view: {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1800,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'name',
  display:     'Name',
  data_type:   'input',
  data_option: {
    type:      'text',
    maxlength: 150,
    null:      false,
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: false,
      },
    },
    edit:   {
      '-all-' => {
        null: false,
      },
    },
    view:   {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    200,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'assignment_timeout',
  display:     'Assignment Timeout',
  data_type:   'integer',
  data_option: {
    maxlength: 150,
    null:      true,
    note:      'Assignment timeout in minutes if assigned agent is not working on it. Ticket will be shown as unassigend.',
    min:       0,
    max:       999_999,
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    300,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'follow_up_possible',
  display:     'Follow-up possible',
  data_type:   'select',
  data_option: {
    default:   'yes',
    options:   {
      yes:        'yes',
      new_ticket: 'do not reopen Ticket but create new Ticket'
    },
    null:      false,
    note:      'Follow-up for closed ticket possible or not.',
    translate: true
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    400,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'follow_up_assignment',
  display:     'Assign Follow-Ups',
  data_type:   'select',
  data_option: {
    default:   'yes',
    options:   {
      true:  'yes',
      false: 'no',
    },
    null:      false,
    note:      'Assign follow-up to latest agent again.',
    translate: true
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    500,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'email_address_id',
  display:     'Email',
  data_type:   'select',
  data_option: {
    default:    '',
    multiple:   false,
    null:       true,
    relation:   'EmailAddress',
    nulloption: true,
    do_not_log: true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    600,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'signature_id',
  display:     'Signature',
  data_type:   'select',
  data_option: {
    default:    '',
    multiple:   false,
    null:       true,
    relation:   'Signature',
    nulloption: true,
    do_not_log: true,
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    600,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'note',
  display:     'Note',
  data_type:   'richtext',
  data_option: {
    type:      'text',
    maxlength: 250,
    null:      true,
    note:      'Notes are visible to agents only, never to customers.',
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-' => {
        null: true,
      },
    },
    view:   {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1500,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Group',
  name:        'active',
  display:     'Active',
  data_type:   'active',
  data_option: {
    null:       true,
    default:    true,
    permission: ['admin.group'],
  },
  editable:    false,
  active:      true,
  screens:     {
    create: {
      '-all-' => {
        null: true,
      },
    },
    edit:   {
      '-all-': {
        null: false,
      },
    },
    view:   {
      '-all-' => {
        shown: false,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    1800,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'aspect',
  display:     'Aspect',
  data_type:   'select',
  data_option: {
    default:    'Other',
    options:    {
      'Cost'        => 'Cost',
      'Security'    => 'Security',
      'Monitoring'  => 'Monitoring',
      'Other'       => 'Other',
    },
    nulloption: true,
    multiple:   false,
    null:       true,
    permission: ['ticket.agent'],
    translate:  false,
  },
  editable:    true,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        shown: true,
        item_class: 'column',
      },
    },
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

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'state_reason',
  display:     'Reason',
  data_type:   'select',
  data_option: {
    default:    '',
    options:    {
      'Completed'     => 'Completed',
      'Suppressed'    => 'Suppressed',
    },
    nulloption: true,
    multiple:   false,
    null:       true,
    permission: ['ticket.agent'],
    translate:  false,
  },
  editable:    true,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        shown: true,
        item_class: 'column',
      },
    },
    edit:          {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    2300,
)

ObjectManager::Attribute.add(
  force:       true,
  object:      'Ticket',
  name:        'hashproperties',
  display:     'Codes',
  data_type:   'input',
  data_option: {
    type:           'text',
    maxlength:      120,
    null:           true,
    permission:     ['ticket.agent'],
  },
  editable:    true,
  active:      true,
  screens:     {
    create_middle: {
      '-all-' => {
        shown: true,
        item_class: 'column',
      },
    },
    edit:          {
      '-all-' => {
        shown: true,
      },
    },
  },
  to_create:   false,
  to_migrate:  false,
  to_delete:   false,
  position:    2500,
)
