class BladesDBPage
    include Capybara::DSL
    PAGE_TITLE = "BathLARP"
    PAGE_TITLE_CONNECTOR = " - "

    def visit_page(url)
        visit url
        self
    end
    
    def and
        self
    end
end

