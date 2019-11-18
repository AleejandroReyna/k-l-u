class WeeksController < ApplicationController

  def  new
    @week = params['week'] ? params['week']['week'] : ""
    @days ||= []
    week_days.each do |day|
      start_date = params["%s_start" % day] ? params["%s_start" % day] : ""
      end_date = params["%s_end" % day] ? params["%s_end" % day] : ""
      @days.push(
          Day.new(week_day: day, start: start_date, end: end_date)
      )
    end
  end

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
  end

  def create
    @days ||= []
    week_days.each do |day| @days.push(Day.new(week_day: day, start: params["%s_start" % day],
                                               end: params["%s_end" % day]))
    end
    @valid = true
    days_count = 0

    loop do
      if !params["%s_all_day" % @days[days_count].week_day]
       @valid = @days[days_count].try_to_save ? true : false
      end
      days_count = days_count + 1
      break if not @valid or days_count == @days.length
    end

    puts("here", @valid)

    if !@valid
      flash[:notice] = "Verify your data and try again"
      return redirect_to action: 'new', params: request.parameters
    end

    @week = Week.new(week_params)
    @week.save
    @days.each do |day|
      day.start = params["%s_all_day" % day.week_day] ? "00:00" : day.start_date
      day.end = params["%s_all_day" % day.week_day] ? "23:59" : day.end_date
      day.week_id = @week.id
      day.save
    end

    flash[:notice] = "Week business hours created"
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

    def week_days
      Array["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
    end
end
