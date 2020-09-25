overview_role = Role.find_by(name: 'Agent (SRE)')
Overview.create_if_not_exists(
  name:      'New incidents',
  link:      'all_new_incidents',
  prio:      1000,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:new).pluck(:id),
    },
    'ticket.group_id' => {
      operator:      'is',
      value:         1,
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'customer',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer priority created_at repeat_count],
    s:                 %w[number title customer priority created_at repeat_count],
    m:                 %w[number title customer priority created_at repeat_count],
    view_mode_default: 's',
  },
)

Overview.create_if_not_exists(
  name:      'New recommendations',
  link:      'all_new_recommendations',
  prio:      1010,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:new).pluck(:id),
    },
    'ticket.group_id' => {
      operator:      'is',
      value:         2,
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'customer',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer created_at repeat_count],
    s:                 %w[number title customer created_at repeat_count],
    m:                 %w[number title customer created_at repeat_count],
    view_mode_default: 's',
  },
)

Overview.create_if_not_exists(
  name:      'Open',
  link:      'all_open',
  prio:      1020,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:work_on_all).pluck(:id),
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'group',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer state owner created_at updated_at repeat_count aspect],
    s:                 %w[number title customer state owner created_at updated_at repeat_count aspect],
    m:                 %w[number title customer state owner created_at updated_at repeat_count aspect],
    view_mode_default: 's',
  },
)

Overview.create_if_not_exists(
  name:      'Escalated',
  link:      'all_escalated',
  prio:      1030,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.escalation_at' => {
      operator: 'within next (relative)',
      value:    '10',
      range:    'minute',
    },
  },
  order:     {
    by:        'escalation_at',
    direction: 'ASC',
  },
  group_by:  'group',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer group owner escalation_at],
    s:                 %w[number title customer group owner escalation_at],
    m:                 %w[number title customer group owner escalation_at],
    view_mode_default: 's',
  },
)

Overview.create_if_not_exists(
  name:          'Replacement',
  link:          'my_replacement',
  prio:          1080,
  role_ids:      [overview_role.id],
  out_of_office: true,
  condition:     {
    'ticket.state_id'                     => {
      operator: 'is',
      value:    Ticket::State.by_category(:open).pluck(:id),
    },
    'ticket.out_of_office_replacement_id' => {
      operator:      'is',
      pre_condition: 'current_user.id',
    },
  },
  order:         {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'group',
  group_direction: 'DESC',
  view:          {
    d:                 %w[title customer owner escalation_at created_at repeat_count aspect],
    s:                 %w[number title customer owner escalation_at created_at repeat_count aspect],
    m:                 %w[number title customer owner escalation_at created_at repeat_count aspect],
    view_mode_default: 's',
  },
)

Overview.create_if_not_exists(
  name:      'Closed & Merged',
  link:      'all_closed_and_merged',
  prio:      1090,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:closed_or_merged).pluck(:id),
    },    
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  view:      {
    d:                 %w[title owner close_at created_at],
    s:                 %w[number title owner close_at created_at],
    m:                 %w[number title owner close_at created_at],
    view_mode_default: 's',
  },
)


overview_role = Role.find_by(name: 'Customer')
Overview.create_if_not_exists(
  name:      'My open tickets',
  link:      'my_open_tickets',
  prio:      1100,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:open).pluck(:id),
    },
    'ticket.customer_id' => {
      operator:      'is',
      pre_condition: 'current_user.id',
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'group',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer updated_at aspect],
    s:                 %w[number title updated_at aspect],
    m:                 %w[number title updated_at aspect],
    view_mode_default: 's',
  },
)
Overview.create_if_not_exists(
  name:      'Closed tickets',
  link:      'closed_tickets',
  prio:      1200,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:closed).pluck(:id),
    },
    'ticket.organization_id' => {
      operator:      'is',
      pre_condition: 'current_user.organization_id',
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'group',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer updated_at aspect state_reason],
    s:                 %w[number title updated_at aspect state_reason],
    m:                 %w[number title updated_at aspect state_reason],
    view_mode_default: 's',
  },
)
Overview.create_if_not_exists(
  name:      'Tickets in progress',
  link:      'tickets_in_progress',
  prio:      1300,
  role_ids:  [overview_role.id],
  condition: {
    'ticket.state_id' => {
      operator: 'is',
      value:    Ticket::State.by_category(:open).pluck(:id),
    },
    'ticket.organization_id' => {
      operator:      'is',
      pre_condition: 'current_user.organization_id',
    },
  },
  order:     {
    by:        'created_at',
    direction: 'DESC',
  },
  group_by:  'aspect',
  group_direction: 'DESC',
  view:      {
    d:                 %w[title customer created_at updated_at],
    s:                 %w[number title created_at updated_at],
    m:                 %w[number title created_at updated_at],
    view_mode_default: 's',
  },
)

