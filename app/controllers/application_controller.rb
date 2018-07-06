# require 'sinatra/base'
#  require '../helpers/application_helpers'

class ApplicationController < Sinatra::Base 
    set :views, 'app/views'
    enable :sessions

    def login?
        if session[:username].nil?
            return false
        else
            return true
        end
    end
    
    def username
        return session[:username]
    end

    get '/' do 
        erb :index
    end 
      
    get "/logout" do
        session[:username] = nil
        redirect "/"
    end
end
    