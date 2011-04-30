class AppsController < ApplicationController
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]

  def index
    @apps = App.all
  end

  def show
    @types = [34,35,36,37,38,39,40]
    update_values(@types)
  end

  def new
    @app = App.new
  end

  # def edit

  def create
    @app = App.new(params[:app])

    if @app.save
      redirect_to(@app, :notice => 'App was successfully created.')
    else
      render :action => :new
    end
  end

  def update
    if @app.update_attributes(params[:app])
      redirect_to(@app, :notice => 'App was successfully updated.')
    else
      render :action => :edit
    end
  end

  def destroy
    @app.destroy

    redirect_to(apps_url)
  end

  private
  def find_app
    @app = App.find(params[:id])
  end
end
