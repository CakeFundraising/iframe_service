window.Cake ?= {}
Cake.Iframe ?= {}

Cake.Iframe.badges ?= {}

Cake.Iframe.badges.countdown = (end_date)->
  arr = end_date.split(/[- :]/)
  end_date = new Date(arr[0], arr[1] - 1, arr[2], arr[3], arr[4], arr[5])
  
  $("#campaign_countdown").countdown end_date, (event) ->
    countdown_section = $(this)
    # days
    countdown_section.find("span.campaign-timer.days").html event.strftime("%-D")
    # hours
    countdown_section.find("span.campaign-timer.hours").html event.strftime("%H")
    # minutes
    countdown_section.find("span.campaign-timer.mins").html event.strftime("%M")
    return
  return