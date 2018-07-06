class LoginController < ApplicationController

    post "/login" do
        # if User.has_key?(params[:username])
        #     user = User[params[:username]]
        #     if user[:passwordhash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
        #         session[:username] = params[:username]
        #         redirect "/"
        #     end
        # end
        User.all.each do |user|
            if params[:username] == user.user_name
                if params[:password] == user.password
                    session[:username] = params[:username]
                    redirect "/"
                end
            end
        end
        erb :error
    end

end