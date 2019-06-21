class UsersController < ApplicationController


  get '/users/:slug' do
    user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end


  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post "/signup" do
    redirect '/tweets' if is_logged_in?
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !is_logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
    if !is_logged_in?
      redirect '/login'
    else
      session.clear
      redirect '/login'
    end
  end

end
