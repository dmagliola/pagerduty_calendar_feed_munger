# pagerduty_calendar_feed_munger

Remove the timestamps of multi-day events in Pagerduty's calendar feed


PagerDuty rota Calendar events (correctly) have start and end times. This is great 
and correct, but for rotas where people think in terms of "which days i'm on call",
this shows one more day.

E.g.: If your rota is Monday and Tuesday, you start Monday at 9am, and hand over Wednesday at 9am...

Your calendar event will show you're on call Monday to Wednesday, because that's how GCalendar shows
multi-day events, and this is **correct** but **confusing**

This tool can be pointed at a Pagerduty calendar feed, and it will look at all the events in it which
span multiple days, and remove their timestamps. That way, it'll show midnight-to-midnight, which is
a lie, but it aligns with how we think about our shifts.

