# HelloWorldController.rb file
# 
# This file is the controller for the HelloWorld model. It contains the methods that are called when the user interacts with the HelloWorld model.
#

class HelloWorldController < ApplicationController
  
  # This method is called when the user navigates to the HelloWorld index page.
  def index
    @hello_world = HelloWorld.new
  end

  # This method is called when the user clicks the submit button on the HelloWorld index page.
  def create
    @hello_world = HelloWorld.new(hello_world_params)
    @hello_world.save
    redirect_to @hello_world
  end

  # This method is called when the user navigates to the show page for a specific HelloWorld object.
  def show
    @hello_world = HelloWorld.find(params[:id])
  end

  private
    # This method is used to whitelist the parameters that are passed in from the user. This is a security measure to prevent users from passing in parameters that are not permitted.
    def hello_world_params
      params.require(:hello_world).permit(:name)
    end
end