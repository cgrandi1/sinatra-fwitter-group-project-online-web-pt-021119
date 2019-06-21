class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    redirect '/tweets/new' if params[:content].empty?
    @tweet = Tweet.create(params)
    @tweet.user = current_user
    @tweet.save
    redirect '/tweets'
  end


  get '/tweets/:id' do
    redirect '/login' if !is_logged_in?
    @tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(@tweet)
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

    get '/tweets/:id/edit' do
      if is_logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet && @tweet.user == current_user

          erb :'tweets/edit'
        else
          redirect '/login'
        end
      else
        redirect '/login'
      end
    end


  patch '/tweets/:id' do
    if is_logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find(params[:id])
        if @tweet && @tweet.user == current_user
          @tweet.update(content: params[:content])
          # @tweet.save
          redirect "/tweets/#{@tweet.id}"
        else
          redirect '/tweets'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
