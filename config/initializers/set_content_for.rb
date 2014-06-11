module ActionView
    module Helpers
        module CaptureHelper
            def set_content_for(name, content = nil, &block)
                @view_flow.set(name, ActiveSupport::SafeBuffer.new)
                content_for(name, content, &block)
            end
        end
    end
end