module CharactersHelper
    def display_character_field(character, partial_name)
        render(:partial => partial_name, :layout => "fieldlist_field", :locals => {
            :character => character, 
            :is_owner => (character.user == current_user),
            :is_gm_for_character => (current_user.is_gm_for? character),
            :is_ref_for_character => (current_user.is_character_ref? and character.user != current_user)
        }).html_safe
    end
    
    def state_actions(character)
        actions = []
        if character.user == current_user and character.approved == false
            actions << { :name => "Edit and resubmit", :url => edit_rejected_character_path(character), :method => :get }
        else
            if character.user == current_user or current_user.is_character_ref?
                actions << { :name => "Reactivate", :url => reactivate_character_path(character), :method => :patch } if character.retired?
                actions << { :name => "Retire", :url => retire_character_path(character), :method => :patch } if character.active?
                actions << { :name => "Perm-kill", :url => perm_kill_character_path(character), :method => :patch, data: { confirm: "Are you sure you want to permanently kill this character?"} } if character.active? or character.retired?
                actions << { :name => (character.user == current_user ? "Request resurrection from perm-death" : "Resurrect from perm-death"), :url => resurrect_character_path(character), :method => :patch } if character.dead?
                actions << { :name => "Recycle", :url => recycle_character_path(character), :method => :patch, data: { confirm: "Are you sure you want to recycle this character? This action cannot be undone." } } if character.can_recycle?
            end
            if current_user.is_character_ref? and character.approved.nil? and character.user != current_user
                actions << { :name => "Approve", :url => approve_character_path(character), :method => :patch }
                actions << { :name => "Reject", :url => reject_character_path(character), :method => :patch }
            end
        end
        return actions
    end
end
