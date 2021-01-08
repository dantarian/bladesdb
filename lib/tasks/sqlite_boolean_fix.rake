desc "Update all boolean database fields from t to 1, or f to 0."
task fix_sqlite_booleans: :environment do
    Board.where("in_character = 't'").update_all(in_character: 1)
    Board.where("in_character = 'f'").update_all(in_character: 0)
    Board.where("closed = 't'").update_all(closed: 1)
    Board.where("closed = 'f'").update_all(closed: 0)
    
    Campaign.where("current = 't'").update_all(current: 1)
    Campaign.where("current = 'f'").update_all(current: 0)

    CharacterPointAdjustment.where("approved = 't'").update_all(approved: 1)
    CharacterPointAdjustment.where("approved = 'f'").update_all(approved: 0)

    Character.where("date_of_birth_public = 't'").update_all(date_of_birth_public: 1)
    Character.where("date_of_birth_public = 'f'").update_all(date_of_birth_public: 0)
    Character.where("approved = 't'").update_all(approved: 1)
    Character.where("approved = 'f'").update_all(approved: 0)
    Character.where("preferred_character = 't'").update_all(preferred_character: 1)
    Character.where("preferred_character = 'f'").update_all(preferred_character: 0)
    Character.where("no_title = 't'").update_all(no_title: 1)
    Character.where("no_title = 'f'").update_all(no_title: 0)

    DeathThresholdAdjustment.where("approved = 't'").update_all(approved: 1)
    DeathThresholdAdjustment.where("approved = 'f'").update_all(approved: 0)

    GameApplication.where("approved = 't'").update_all(approved: 1)
    GameApplication.where("approved = 'f'").update_all(approved: 0)

    GameAttendance.where("want_food = 't'").update_all(want_food: 1)
    GameAttendance.where("want_food = 'f'").update_all(want_food: 0)

    Game.where("open = 't'").update_all(open: 1)
    Game.where("open = 'f'").update_all(open: 0)
    Game.where("debrief_started = 't'").update_all(debrief_started: 1)
    Game.where("debrief_started = 'f'").update_all(debrief_started: 0)
    Game.where("non_stats = 't'").update_all(non_stats: 1)
    Game.where("non_stats = 'f'").update_all(non_stats: 0)
    Game.where("attendance_only = 't'").update_all(attendance_only: 1)
    Game.where("attendance_only = 'f'").update_all(attendance_only: 0)

    GuildMembership.where("provisional = 't'").update_all(provisional: 1)
    GuildMembership.where("provisional = 'f'").update_all(provisional: 0)
    GuildMembership.where("approved = 't'").update_all(approved: 1)
    GuildMembership.where("approved = 'f'").update_all(approved: 0)

    Guild.where("proscribed = 't'").update_all(proscribed: 1)
    Guild.where("proscribed = 'f'").update_all(proscribed: 0)

    Message.where("deleted = 't'").update_all(deleted: 1)
    Message.where("deleted = 'f'").update_all(deleted: 0)
    
    MonsterPointAdjustment.where("approved = 't'").update_all(approved: 1)
    MonsterPointAdjustment.where("approved = 'f'").update_all(approved: 0)

    MonsterPointDeclaration.where("approved = 't'").update_all(approved: 1)
    MonsterPointDeclaration.where("approved = 'f'").update_all(approved: 0)

    Page.where("show_to_non_users = 't'").update_all(show_to_non_users: 1)
    Page.where("show_to_non_users = 'f'").update_all(show_to_non_users: 0)

    Role.where("admin_only = 't'").update_all(admin_only: 1)
    Role.where("admin_only = 'f'").update_all(admin_only: 0)

    SidebarCategory.where("show_for_non_users = 't'").update_all(show_for_non_users: 1)
    SidebarCategory.where("show_for_non_users = 'f'").update_all(show_for_non_users: 0)
    SidebarCategory.where("show_for_admin_users_only = 't'").update_all(show_for_admin_users_only: 1)
    SidebarCategory.where("show_for_admin_users_only = 'f'").update_all(show_for_admin_users_only: 0)
    SidebarCategory.where("editable = 't'").update_all(editable: 1)
    SidebarCategory.where("editable = 'f'").update_all(editable: 0)
    SidebarCategory.where("always_open = 't'").update_all(always_open: 1)
    SidebarCategory.where("always_open = 'f'").update_all(always_open: 0)

    SidebarEntry.where("editable = 't'").update_all(editable: 1)
    SidebarEntry.where("editable = 'f'").update_all(editable: 0)

    User.where("is_admin = 't'").update_all(is_admin: 1)
    User.where("is_admin = 'f'").update_all(is_admin: 0)

end