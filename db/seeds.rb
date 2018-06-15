MemberDivision.delete_all
User.delete_all

MemberDivision.create(name: 'YTL Cement')
MemberDivision.create(name: 'YTL Power')
MemberDivision.create(name: 'YTL Digital')

Category.create(name: 'Electronic')
Category.create(name: 'Hardware')
Category.create(name: 'Books')

User.create([{
  name: 'Demo Account',
  email: 'demo@demo.com',
  password: "change_me",
  remember_created_at: nil
}])

User.create([{
  name: 'Joseph Wong',
  email: 'joseph@ytl.com',
  password: "qwe123",
  remember_created_at: nil,
  member_division_id: MemberDivision.pluck(:id).sample
}])

User.create([{
  name: 'Liren Yeo',
  email: 'liren@not-ytl.com',
  password: "qwe123",
  remember_created_at: nil,
  member_division_id: MemberDivision.pluck(:id).sample
}])