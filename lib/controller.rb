class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    redirect '/'
  end

  get '/gossip/:id' do
    id = params['id'].to_i
    erb :show, locals: {gossip: Gossip.find(id), index:id, comments: Gossip.find(id).display_comment}
  end

  get '/edit/:id' do
    id = params['id'].to_i
    erb :edit, locals: {gossip_to_edit: Gossip.find(id), index:id}
  end

  post '/edit/:id' do
    id = params['id'].to_i
    gossip_to_edit = Gossip.find(id)
    gossip_to_edit.edit(params["gossip_author"],params["gossip_content"],DateTime.now.strftime("%H:%M, le %d/%m/%Y"), id)
    redirect '/'
  end

  post '/gossip/:id' do
    id = params['id'].to_i
    gossip_to_comment = Gossip.find(id)
    gossip_to_comment.add_comment(params["comment_author"],params["comment_content"],id)
    redirect "gossip/#{id}"
  end
end