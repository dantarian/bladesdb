class UserMailer < ActionMailer::Base
    default from: "no-reply@bathlarp.co.uk"

    def user_approval(user)
        setup_email(user)
        @subject += I18n.t("email_subjects.approved")
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
        setup_email(adjustment.character.user)
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

    def game_application_unsuccessful(application)
        setup_email(application.user)
        @application = application
        @subject += "Game Application #{application.game.start_date.to_s} Unsuccessful"
        @recipients += ["committee@bathlarp.co.uk"]
        mail(to: @recipients, subject: @subject)
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

    def mp_spend_cost_increase(mp_spend, old_cost)
        mp_spend_cost_change(I18n.t("email_subjects.mp_cost_increased"), mp_spend, old_cost)
    end

    def mp_spend_cost_decrease(mp_spend, old_cost)
        mp_spend_cost_change(I18n.t("email_subjects.mp_cost_decreased"), mp_spend, old_cost)
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
            ["committee@bathlarp.co.uk"]
        else
            ["characterrefs@bathlarp.co.uk"]
        end
        @thing_approved = thing_approved
        @subject += (thing_approved.approved ? "Approved" : "Rejected")
        mail(to: @recipients, subject: @subject)
    end

    def app_made(application)
        @recipients += ["committee@bathlarp.co.uk"]
        @subject += "Game Application #{application.game.start_date.to_s}"
        @application = application
        mail(to: @recipients, subject: @subject)
    end

    def mp_spend_cost_change(subject, mp_spend, old_cost)
        setup_email(mp_spend.character.user)
        @subject += subject
        @character = mp_spend.character
        @spent_on = mp_spend.spent_on
        @old_cost = old_cost
        @new_cost = mp_spend.monster_points_spent
        mail(to: @recipients, subject: @subject)
    end
end
