class UserMailer < ActionMailer::Base
    default from: "no-reply@pencethren.org"

    def user_approval(user)
        setup_email(user)
        @subject += "Your account has been approved"
        mail(to: @recipients, subject: @subject)
    end
  
    def character_approval(character)
        setup_email(character.user)
        @subject += "Character "
        approval(character)
    end
    
    def guild_change_approval(guild_membership)
        setup_email(guild_membership.character.user)
        @subject += "Guild Change Request " + (guild_membership.provisional? ? "Provisionally " : "")
        @guild_change_details = if guild_membership.guild.nil?
                                    if guild_membership.character.current_guild_membership.guild.nil?
                                        "not be a member of any guild"
                                    else
                                        "leave the #{guild_membership.character.current_guild_membership.full_guild_name}"
                                    end
                                else
                                    if guild_membership.character.guild.nil? or guild_membership.character.current_guild_membership == guild_membership
                                        "join the #{guild_membership.full_guild_name}"
                                    else
                                        "move from the #{guild_membership.character.current_guild_membership.full_guild_name} to the #{guild_membership.full_guild_name}"
                                    end
                                end
        approval(guild_membership)
    end
    
    def character_point_adjustment_approval(adjustment)
        setup_email(adjustment.user)
        @subject += "Character "
        approval(adjustment)
    end
    
    def monster_point_adjustment_approval(adjustment)
        setup_email(adjustment.user)
        @subject += "Monster Point Adjustment "
        approval(adjustment)
    end
    
    def monster_point_declaration_approval(declaration)
        setup_email(declaration.user)
        @subject += "Monster Point Declaration "
        approval(declaration)
    end
    
    def death_threshold_adjustment_approval(adjustment)
        setup_email(adjustment.character.user)
        @subject += "Death Threshold Adjustment "
        approval(adjustment)
    end
    
    def game_application_made(application)
        setup_email(application.user)
        app_made(application)
    end
    
    def game_application_withdrawn(application)
        setup_email(application.user)
        app_made(application)
    end
    
    def game_application_approval(application)
        setup_email(application.user)
        @subject += "Game Application #{application.game.start_date.to_s} "
        approval(application)
    end
    
    def play_attendance(attendance)
        setup_email(attendance.user)
        @recipients += attendance.game.gamesmasters.pluck(:email).to_a
        @subject += attendance.confirm_state.capitalize
        @subject += " for "
        @subject += attendance.game.title.nil? ? "Untitled" : attendance.game.title
        @subject += " on #{attendance.game.start_date.to_s} "
        @attendance = attendance
        @state = attendance.confirm_state.to_s
        mail(to: @recipients, subject: @subject)
    end

    protected
    def setup_email(user)
        @subject = "[BathLARP] "
        @recipients  = [user.email]
        @user        = user
    end

    def approval(thing_approved)
        @recipients += case thing_approved.class.name
        when "GameApplication"
            ["committee@pencethren.org"]
        else
            ["characterrefs@pencethren.org"]
        end
        @thing_approved = thing_approved
        @subject += (thing_approved.approved ? "Approved" : "Rejected")
        mail(to: @recipients, subject: @subject)
    end
    
    def app_made(application)
        @recipients += ["committee@pencethren.org"]
        @subject += "Game Application #{application.game.start_date.to_s}"
        @application = application
        if (application.game.start_date - 1.months) > Date.today
            @response_date = application.game.start_date - 1.months
        else
            @response_date = application.game.start_date - 1.days
        end
        mail(to: @recipients, subject: @subject)
    end
    
end
