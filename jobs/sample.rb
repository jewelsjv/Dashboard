current_valuation = 0
current_karma = 0

SCHEDULER.every '2s' do
  last_valuation = current_valuation
  last_karma     = current_karma
  current_valuation = 50
  current_karma     = rand(200000)
  the_time = Time.now

  send_event('valuation', { current: current_valuation, last: last_valuation })
  send_event('welcome', { title: "Welcome", text: "Random stuff", moreinfo: "The time now is #{the_time}" })
  send_event('karma', { current: current_karma, last: last_karma })
  send_event('synergy',   { value: 100 })
end