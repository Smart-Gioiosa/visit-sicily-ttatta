class ApplicationController < ActionController::Base
    #protect_from_forgery with: :null_session #Da inserire solo per utilizzare postman
    allow_browser versions: :modern
end
