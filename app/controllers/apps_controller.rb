class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def edit
    @app = App.find(params[:id])
  end

  def create
    @app = App.new(params[:app])

    if @app.save
      redirect_to(@app, :notice => 'App was successfully created.')
    else
      render :action => :new
    end
  end

  def update
    @app = App.find(params[:id])

    if @app.update_attributes(params[:app])
      redirect_to(@app, :notice => 'App was successfully updated.')
    else
      render :action => :edit
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy

    redirect_to(apps_url)
  end
end
