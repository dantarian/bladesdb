class CreatePermissions < ActiveRecord::Migration
    def self.up
        create_table :permissions do |t|
            t.references :role, :null => false
            t.references :user, :null => false
            t.timestamps
        end

        # This is kind of bad practice, but seems to be a bit beyond the scope of the seeding system.
        Role.create( :rolename => 'administrator' )

        user = User.new
        user.login = "warren.jones"
        user.email = "warren@pencethren.org"
        user.name = "Warren Jones"
        user.password = "changeme"
        user.password_confirmation = "changeme"
        user.approved_at = Time.now.utc
        user.save( false )
        user.send( :register! )
        user.send( :activate! )

        role = Role.find_by_rolename( "administrator" )
        user = User.find_by_login( "warren.jones" )
        permission = Permission.new
        permission.role = role
        permission.user = user
        permission.save( false )
    end

    def self.down
        drop_table :permissions
        Role.find_by_rolename( "administrator" ).destroy
        User.find_by_login( "warren.jones" ).destroy
    end
end
