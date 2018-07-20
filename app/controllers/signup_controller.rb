 class SignupController < ApplicationController

#     get "/signup" do
#         erb :signup
#     end

#     post "/signup" do
#         # password_salt = BCrypt::Engine.generate_salt
        r1 = /[a-z]+/
        r2 = /[A-Z]+/
        r3 = /[0-9]+/
        r4 = /[\`\~\!\@\#\$\%\^\&\*\(\)\_\-\=\+\/\?\>\.\,\<\'\"\;\:\]\}\[\{\|\\]+/
        
#         if (params[:password].match?(r1) && params[:password].match?(r2) && params[:password].match?(r3) && params[:password].match?(r4) && params[:password].length>=8 && params[:password] == params[:checkpassword])
#             # password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
#             #ideally this would be saved into a database, hash used just for sample
#             # User[params[:username]] = {
#             #     :salt => password_salt,
#             #     :passwordhash => password_hash 
#             # }
#             usr = User.new(user_name: params['username'], password: params['password'])
#             if usr.valid?
#                 usr.save
#                 session[:username] = params[:username]
#                 redirect "/"
#             else 
#                 erb :sameuser
#             end
#         else
#             erb :validate
#         end
#     end


    get '/signup' do
        content_type :json
        return {'status' => 'success', :key => "value"}.to_json
    end

    post '/signup' do
        postData = JSON.parse(request.body.read.to_s)
        puts postData,
        r1 = /[a-z]+/
        r2 = /[A-Z]+/
        r3 = /[0-9]+/
        r4 = /[\`\~\!\@\#\$\%\^\&\*\(\)\_\-\=\+\/\?\>\.\,\<\'\"\;\:\]\}\[\{\|\\]+/        
        eAdd = /^([a-zA-Z0-9\.\_])+@([a-zA-Z0-9])+.([a-zA-Z]{1,3})$/
        un = /^[a-zA-Z0-9_]+$/
        username = User.find_by(Username: postData['userName'])
        email = User.find_by(Email: postData['email'])
        if(username.nil? && email.nil? && postData['userName'].match?(un) && postData['email'].match?(eAdd) && postData['password'].match?(r1) && postData['password'].match?(r2) && postData['password'].match?(r3) && postData['password'].match?(r4) && postData['password'].length>=8) 
            User.create({
                FirstName: postData['firstName'],
                LastName: postData['lastName'],
                Username: postData['userName'],
                Email: postData['email'],
                Password: postData['password'],
                UserType: postData['usertype']
            })
            Session.create!({
                UserId: postData['userName'],
                Created_at: Time.now,
                Token: Base64::encode64(Time.now.to_s + postData['userName'].to_s).strip,
                status: 1
            })
            session[:username] = postData['userName']
            content_type :json
            ses = Session.find_by(status: true).Token
            {'status' => 'success', 'data' => 'saved', :access => true, :detail => ses, :type => postData['usertype']}.to_json
        elsif(!username.nil? && !email.nil?)
            content_type :json
            {'status' => 'fail', 'data' => 'not saved', 'message' => "username and email already taken", :access => false}.to_json    
        elsif(!username.nil?)
            content_type :json
            {'status' => 'fail', 'data' => 'not saved', 'message' => "username already taken", :access => false}.to_json
        elsif(!email.nil?)
            content_type :json
            {'status' => 'fail', 'data' => 'not saved', 'message' => "email already taken", :access => false}.to_json    
        else
            content_type :json
            {'status' => 'fail', 'data' => 'not saved', 'message' => "recheck your username and password to be valid", :access => false}.to_json 
        end    
    end

 end