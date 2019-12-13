module DateHelper

  def pretty_link(date)
    if date.class == Time
      date.to_s.split(' ').first
    end
  end

  def greeting
    case Time.now.hour
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
