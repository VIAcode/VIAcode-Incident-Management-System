Group.create_if_not_exists(
  id:            1,
  name:          'Incidents',
  signature_id:  Signature.first.id,
  note:          'Standard Group/Pool for Tickets.',
  updated_by_id: 1,
  created_by_id: 1
)

Group.create_if_not_exists(
  id:            2,
  name:          'Recommendations',
  note:          'Recommendations Group.',
  updated_by_id: 1,
  created_by_id: 1
)
