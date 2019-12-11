module DateHelper
  def today
    Date.today.to_s
  end

  def pretty_link(date)
    if date.class == Time
      date.to_s.split(' ').first
    end
  end

  def greeting
    case Time.now.hour
    when 6..11
      return "Good morning!"
    when 12..16
      return "Good afternoon!"
    when 17..20
      return "Good evening!"
    when 21..24
      return "Hopefully you aren't watering the plants this late!"
    else
      return "Do plants need to be watered in the middle of the night?"
    end
  end

end
