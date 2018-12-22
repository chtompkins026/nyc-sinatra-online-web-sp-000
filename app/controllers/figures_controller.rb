class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end
  
  get '/figures/new' do 
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :"figures/new"
  end 
  
  post '/figures' do
    @figure = Figure.create(params[:figure])
    lmn = params[:landmark][:name] 
    t_name = params[:title][:name]
    
    @figure.landmarks << Landmark.create(params[:landmark])  unless lmn.empty?
    
    @figure.titles << Title.create(params[:title])  unless t_name.empty? 
    
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  
  get '/figures/:id' do 
    n_id = params[:id]
    @figure = Figure.find(n_id)
    erb :"/figures/show"
  end 
  
  get '/figures/:id/edit' do
    n_id = params[:id]
    @figure = Figure.find(n_id)
    @landmarks = Landmark.all 
    @titles = Title.all 
    
    erb :"/figures/edit"
  end 
  
  patch '/figures/:id' do
    land_name = params[:landmark][:name]
    title_name = params[:title][:name]
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    @figure.landmarks << Landmark.create(params[:landmark]) unless land_name.empty?
    @figure.titles << Title.create(params[:title]) unless title_name.empty?
    
    @figure.save
    redirect_to '/figures/#{@figure.id}'
  end
end
