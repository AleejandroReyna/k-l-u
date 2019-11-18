class WeeksController < ApplicationController

  def  new
    days = Array["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
    @days ||= []
    days.each { |day| @days.push(Day.new(week_day: day)) }
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
      params.require(:week).permit(:week,
                                   :mon_start, :mon_end, :mon_all_day,
                                   :tue_start, :tue_end, :tue_all_day,
                                   :wed_start, :wed_end, :wed_all_day,
                                   :thu_start, :thu_end, :thu_all_day,
                                   :fri_start, :fri_end, :fri_all_day,
                                   :sat_start, :sat_end, :sat_all_day,
                                   :sun_start, :sun_end, :sun_all_day)
    end
end
