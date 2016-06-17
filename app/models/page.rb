class Page < ActiveRecord::Base
    has_one :sidebar_entry

    validates_presence_of   :title
    validates_uniqueness_of :title,
                            :case_sensitive => false,
                            :message => I18n.t("page.validation.title_uniqueness")
    validates_length_of     :title, :maximum => 50
    validates_presence_of   :content
    
    auto_strip_attributes :title

    def get_content
        if self.content
            RedCloth.new( self.content, [:filter_html] ).to_html.html_safe
        else
            nil
        end
    end

    def editable_by?( user )
        if user and ( user.has_role?( "administrator" ) or user.has_role?( "committee" ) )
            true
        else
            # We'll be draconian for now.
            false
        end
    end
end
