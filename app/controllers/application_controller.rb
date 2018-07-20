# require 'sinatra/base'
#  require '../helpers/application_helpers'

class ApplicationController < Sinatra::Base 
    register Sinatra::CrossOrigin
    set :views, 'app/views'
    enable :sessions
    enable :cross_origin

    # def login?
    #     if session[:username].nil?
    #         return false
    #     else
    #         return true
    #     end
    # end
    
    # def username
    #     return session[:username]
    # end

    options '*' do
        headers['Access-Control-Allow-Origin'] = "*"
    end

    post '/before_login' do
        postData = JSON.parse(request.body.read.to_s)
        user = User.find_by(Username: postData['activeuser'])
        puts user.Username
        if(session[:username] == user.Username)
            puts "in if of before_login"
            content_type :json
            {'message' => 'already logged In', :access => true}.to_json
        else 
            puts "in else of before_login"
            content_type :json
            {'message' => 'not previously logged in', :access => false}.to_json
        end
    end

    get "/dashboard" do
        content_type :json
        {:key1 => 'Hello!!!', 'status' => 'success'}.to_json
    end

    post "/logout" do
        postData = JSON.parse(request.body.read.to_s)
        puts postData
        puts postData['usertoken']
        Session.where(Token: postData['usertoken']).update({
            status: 0
        })
        content_type :json
        {:key1 => true, 'status' => 'success', 'message' => 'logged out'}.to_json
        session[:username] = nil
        # redirect "/"
    end
end
    