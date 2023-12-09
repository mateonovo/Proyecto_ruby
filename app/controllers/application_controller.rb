class ApplicationController < ActionController::Base

    def not_found
       render file: "#{Rails.root}/app/views/errors/404.html", layout: false, status: :not_found
    end

    def forbidden
        render file: "#{Rails.root}/app/views/errors/403.html", layout: false, status: :forbidden
    end

end

    