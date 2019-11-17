class WeeksController < ApplicationController

  def  new
  end

  def create
    render plain: params[:week].inspect
  end
end
