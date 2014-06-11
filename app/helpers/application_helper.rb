# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

    def money_for_display(amount)
        groats = (amount / MONEY_BASE).floor
        florins = amount % MONEY_BASE
        if (amount.abs < MONEY_BASE)
            "#{amount}f"
        elsif florins == 0
            "#{groats}g"
        else
            "#{groats}g #{florins}f"
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

end
