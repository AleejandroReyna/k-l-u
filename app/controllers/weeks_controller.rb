class WeeksController < ApplicationController

  def  new
  end

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
  end

  def create
    @week = Week.new(week_params)
    print(@week)
    @week.save
    redirect_to @week
  end

  private
    def week_params
      params.require(:week).permit(:week)
    end
end
