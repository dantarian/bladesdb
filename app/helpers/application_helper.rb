# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

    def money_for_display(amount)
        sign = ""
        sign = "-" if amount < 0 
        groats = (amount.abs / MONEY_BASE).floor
        florins = amount.abs % MONEY_BASE
        if amount == 0
            "0g"
        elsif (amount.abs < MONEY_BASE)
            "#{sign}#{florins}f"
        elsif florins == 0
            "#{sign}#{groats}g"
        else
            "#{sign}#{groats}g #{florins}f"
        end
    end
    
    def render_dialog(partial_name, title, button = "Save", action = nil, fields = nil)
        render :partial => partial_name, :layout => "layouts/dialog", :locals => { 
          :title => title, 
          :button => button, 
          :action => action, 
          :fields => fields 
        }
    end
    
    def close_dialog_and_replace_element(element_id, partial_name, locals = {})
        render :partial => partial_name, :layout => "layouts/close_dialog_and_replace_element", :locals => { :element_id => element_id }.merge(locals)
    end
    
    def replace_element(element_id, partial_name, locals = {})
        render :partial => partial_name, :layout => "layouts/replace_element", :locals => { :element_id => element_id }.merge(locals)
    end
    
    def pending_game_apps
        Game.future_games.to_a.select{|game| game.has_pending_applications?}.count
    end

end
