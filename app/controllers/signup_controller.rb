class SignupController < ApplicationController

    get "/signup" do
        erb :signup
    end

    post "/signup" do
        # password_salt = BCrypt::Engine.generate_salt
        r1 = /[a-z]+/
        r2 = /[A-Z]+/
        r3 = /[0-9]+/
        r4 = /[\`\~\!\@\#\$\%\^\&\*\(\)\_\-\=\+\/\?\>\.\,\<\'\"\;\:\]\}\[\{\|\\]+/
        if (params[:password].match?(r1) && params[:password].match?(r2) && params[:password].match?(r3) && params[:password].match?(r4) && params[:password].length>=8 && params[:password] == params[:checkpassword])
            # password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
            #ideally this would be saved into a database, hash used just for sample
            # User[params[:username]] = {
            #     :salt => password_salt,
            #     :passwordhash => password_hash 
            # }
            User.new(user_name: params['username'], password: params['password']).save
            session[:username] = params[:username]
            redirect "/"
        else
            erb :validate
        end
    end

end