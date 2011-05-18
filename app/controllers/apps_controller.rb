class AppsController < ApplicationController
  before_filter :find_app, :only => [:show, :edit, :update, :destroy]

  def index
    @apps = App.all
  end

  def show
    case @app.id
      when 1
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

      when 2
        @types = [38,39,40,30309,30310,30311,30375,30376,30377,30370,30378,30371,30372,30373,30374]
        @inputs = {
          30375 => 'Fullerite-C28',
          30376 => 'Fullerite-C32',
          30377 => 'Fullerite-C320',
          30370 => 'Fullerite-C50',
          30378 => 'Fullerite-C540',
          30371 => 'Fullerite-C60',
          30372 => 'Fullerite-C70',
          30373 => 'Fullerite-C72',
          30374 => 'Fullerite-C84'
        }
      else @inputs = { }
    end
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
