class ApplicationController < ActionController::Base

    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::ActionControllerError, with: :render_403

  
    def not_found
        raise ActionController::RoutingError.new('Not Found')
    end

    def forbidden
        raise ActionController::ActionControllerError.new('Forbidden')
    end
    
    private
  
    def render_404
      render file: "#{Rails.root}/app/views/errors/404.html", layout: false, status: :not_found
    end
  
    def render_403
      render file: "#{Rails.root}/app/views/errors/403.html", layout: false, status: :forbidden
    end
  end