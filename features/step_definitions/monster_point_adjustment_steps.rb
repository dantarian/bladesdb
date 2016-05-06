Given(/^the user has a monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.first, 20)
end

Given(/^the other user has a monster point adjustment$/) do
  UserTestHelper.add_monster_point_adjustment(User.all.second, 15, nil, User.first)
end