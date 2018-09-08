class DisplaysController < ApplicationController
  def show
    @display = Display.find(params[:id])
  end
end
