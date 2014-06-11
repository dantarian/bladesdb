# # db/fixtures/roles.rb
# # Basic system roles.
# 
# Role.seed( :rolename ) do |r|
    # r.rolename = "committee"
# end
# 
# Role.seed( :rolename ) do |r|
    # r.rolename = "characterref"
# end
# 

Role.seed( :rolename ) do |r|
    r.rolename = "firstaider"
end

Role.seed( :rolename ) do |r|
    r.rolename = "experiencedgm"
end

Role.seed( :rolename ) do |r|
    r.rolename = "insurance"
end

Role.seed( :rolename ) do |r|
    r.rolename = "webonly"
end