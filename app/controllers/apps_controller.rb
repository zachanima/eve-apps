class AppsController < ApplicationController
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]

  def index
    @apps = App.all
  end

  def show
    @types = [34,35,36,37,38,39,40]
    @inputs = {
      22 => 'Arkonor',
      1223 => 'Bistot',
      1225 => 'Crokite',
      1232 => 'Dark Ochre',
      1229 => 'Gneiss',
      21 => 'Hedbergite',
      1231 => 'Hemorphite',
      1226 => 'Jaspet',
      20 => 'Kernite',
      1227 => 'Omber',
      18 => 'Plagioclase',
      1224 => 'Pyroxeres',
      1228 => 'Scordite',
      19 => 'Spodumain',
      1230 => 'Veldspar'
    }
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
