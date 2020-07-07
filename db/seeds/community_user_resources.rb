Organization.create_if_not_exists(
  id:   1,
  name: 'Default SRE Provider',
)

Organization.create_if_not_exists(
  id:   2,
  name: 'Customer'
)

user_admin = User.create_or_update(
  id:              2,
  login:           'admin',
  firstname:       'Admin',
  lastname:        'User',
  email:           '',
  password:        'admin',
  active:          true,
  roles:           [ Role.find_by(name: 'Admin'), Role.find_by(name: 'Agent (SRE)') ],
)

UserInfo.current_user_id = user_admin.id

if Ticket.count.zero?
  ticket = Ticket.create!(
    group_id:    Group.find_by(name: 'Incidents').id,
    customer_id: 1,
    title:       'Welcome to VIAcode Incident Management System for Azure!',
  )
  Ticket::Article.create!(
    ticket_id: ticket.id,
    type_id:   Ticket::Article::Type.find_by(name: 'phone').id,
    sender_id: Ticket::Article::Sender.find_by(name: 'Customer').id,
    from:      'VIAcode Sales <sales@viacode.com>',
    body:      'Welcome!
    <br><br>
    Thank you for choosing VIAcode Incident Management System for Azure.
    <br><br>
    Let VIAcode deal with these alerts & manage your Azure cloud operation for free; <a href="https://www.viacode.com/services/azure-managed-services/?utm_source=product&utm_medium=email&utm_campaign=VIMS&utm_content=userinviteemail">activate here</a>',
    content_type: 'text/html',
    internal:  false,
  )

  ticket = Ticket.create!(
    group_id:    Group.find_by(name: 'Incidents').id,
    customer_id: 1,
    title:       'Change admin password and enter email',
    priority_id: 3,
  )
  Ticket::Article.create!(
    ticket_id: ticket.id,
    type_id:   Ticket::Article::Type.find_by(name: 'phone').id,
    sender_id: Ticket::Article::Sender.find_by(name: 'Customer').id,
    body:      '<a href="#manage/users">Please change admin password and enter email</a>',
    content_type: 'text/html',
    internal:  false,
  )
end

UserInfo.current_user_id = 1

