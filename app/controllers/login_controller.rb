class LoginController < ApplicationController

    # post "/login" do
    #     # if User.has_key?(params[:username])
    #     #     user = User[params[:username]]
    #     #     if user[:passwordhash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
    #     #         session[:username] = params[:username]
    #     #         redirect "/"
    #     #     end
    #     # end
    #     user= User.where(user_name: params[:username])
    #     if params[:password] == user.pluck(:password)[0]
    #         session[:username] = params[:username]
    #         redirect "/"
    #     end
        
    #     erb :error
    # end

    get '/login' do
        content_type :json
        return {'status' => 'success', :key => "value"}.to_json
    end
    
    post '/login' do
        postData = JSON.parse(request.body.read.to_s)
        # puts "I got some JSON: #{post_data.inspect}"
        puts "inPost in back"
        puts session[:username]
        puts postData
        name = postData['username']
        user = User.find_by(Username: name)
        type = user.UserType
        puts type
        puts name
        puts postData['password']
        if(!user.nil?)
            puts user.Password
            if(user.Password == postData['password'])
                puts "logged In"
                Session.where(UserId: user.id).update(status: false)
                Session.create!({
                    UserId: user.id,
                    Created_at: Time.now,
                    Token: Base64::encode64(Time.now.to_s + user.id.to_s).strip,
                    status: 1
                })
                ses = Session.find_by(status: true).Token
                puts "session created "
                session[:username] = user.Username
                puts session[:username]
                content_type :json
                {'message' => 'logged In', :access => true, :detail => ses, :type => type}.to_json
            else
                content_type :json
                {'message' => 'Check your password and usertype', :access => false}.to_json
            end
        else 
            puts "NOOOOOOOOO"
            content_type :json
            {'message' => 'Username not valid, Access Denied', :access => false}.to_json
        end 

    end

end