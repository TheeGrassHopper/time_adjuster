# frozen_string_literal: true

class TimeAdjuster
  REGEXP_STRING = /^(12|11|10|0?\d):([012345]\d)\s+(AM|PM)/.freeze
  attr_accessor :time, :adjusted_min, :strhours, :strminutes, :meridian

  def initialize(time:, adjusted_min:)
    @time = time
    @adjusted_min = adjusted_min

    #check if arg in type
    raise ArgumentError, "Argument formate error" if time.class != String || adjusted_min.class != Integer

    #check if time in valid format
    raise(ArgumentError, "Invalid time: #{time.strip}") unless time[REGEXP_STRING]
  end

  def add_minutes
    adjusted_hours, adjusted_minutes = total_minutes.divmod(60)
    puts adjusted_hours
    if adjusted_hours > 12
      adjusted_hours -= 12
      meridian = "PM"
    elsif adjusted_hours == 12
      meridian = "PM"
    else
      meridian = "AM"
    end

    "%d:%02d %s" % [adjusted_hours, adjusted_minutes, meridian]
  end

  private

  def time_match
    @time_match = time.strip.match(REGEXP_STRING)
  end

  def time_match_sections
    #calculate new time
    @strhours, @strminutes, @meridian = time_match.captures
  end

  def total_minutes
    time_match_sections
    hours = (meridian == "AM" ? strhours.to_i : strhours.to_i + 12)
    # we only want the minutes that fit within a day
    @total_minutes = (hours * 60 + strminutes.to_i + adjusted_min) % (24*60)
  end

end

puts TimeAdjuster.new(time: "09:13 AM", adjusted_min: 200).add_minutes
