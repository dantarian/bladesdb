Given(/^the user has a monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.first, 20)
end

Given(/^the other user has a monster point declaration$/) do
  UserTestHelper.add_monster_point_declaration(User.all.second, 15, nil, User.first)
end