class BladesDBPage
    include Capybara::DSL
    include RSpec::Matchers
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

