module DateHelper
  include CalendarHelper

  def pretty_link(date)
    if date.class == Time
      date.to_s.split(' ').first
    end
  end

  def render_calendar_cell(d)
    msg = ''
    link = "/days/#{d}"
    msg += "<a href=#{link}>#{d.day}<br>"
    if (!(date = Day.where(date: d).first).nil? && date.plants.size > 0)
      msg += "🌱"
    else
      msg += "🆗"
    end
    msg += "</a>"
  end

  def greeting
    case Time.current.hour
    when 6..11
      "Good morning!"
    when 12..16
      "Good afternoon!"
    when 17..20
      "Good evening!"
    when 21..24
      "Hopefully you aren't watering the plants this late!"
    else
      "Do plants need to be watered in the middle of the night?"
    end
  end

end
