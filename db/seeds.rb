urs = User.create!(email: 'u@z.ch',
                  username: 'Urs',
                  password: '12345678',
                  password_confirmation: '12345678')

oliver = User.create!(email: 'o@s.ch',
                     username: 'Oliver',
                     password: '12345678',
                     password_confirmation: '12345678')

arun = User.create!(email: 'a@s.ch',
                   username: 'Arun',
                   password: '12345678',
                   password_confirmation: '12345678')


event1 = Event.new(title: '10km run',
                      description: 'Who wants to run 10km with me? Love me!!!!',
                      owner: arun,
                      sport_id: 1,
                      location: 'Zurich',
                      deadline: 2.days.from_now )
event1_date1 = event1.spoodle_dates.new(from: 3.days.from_now, to: 3.days.from_now + 2.hours)
event1_date2 = event1.spoodle_dates.new(from: 4.days.from_now, to: 4.days.from_now + 2.hours)
event1_date1.availabilities.new(user: urs, weight: 0.7)
event1_date1.availabilities.new(user: oliver, weight: 0.5)
event1_date2.availabilities.new(user: arun, weight: 1)
event1.invitations.new(user: urs)
event1.invitations.new(user: oliver)
event1.event_data = EventData.new( distance:100)

event1.save!


event2 = Event.new(title: '20km with Sir Stapleton',
                      description: 'Join me now!',
                      owner: oliver,
                      sport_id: 1,
                      location: 'Bern',
                      deadline: 2.minutes.from_now )
event2_date1 = event2.spoodle_dates.new(from: 5.minutes.from_now, to: 10.minutes.from_now)
event2_date2 = event2.spoodle_dates.new(from: 10.minutes.from_now, to: 15.minutes.from_now)
event2_date1.availabilities.new(user: oliver, weight: 0.5)
event2_date2.availabilities.new(user: arun, weight: 1)
event2.invitations.new(user: arun)
event2.event_data = EventData.new(distance:200)
event2.save!


event3 = Event.new(title: '25km with Sir Stapleton',
                   description: 'Join me now!',
                   owner: oliver,
                   sport_id: 1,
                   location: 'Hochschulstrasse 4, Bern',
                   deadline: 20.seconds.from_now )
event3_date1 = event3.spoodle_dates.new(from: 30.seconds.from_now, to: 10.minutes.from_now)
event3_date2 = event3.spoodle_dates.new(from: 10.minutes.from_now, to: 15.minutes.from_now)
event3_date1.availabilities.new(user: oliver, weight: 0.9)
event3_date2.availabilities.new(user: oliver, weight: 0.7)
event3.invitations.new(user: arun)
event3.event_data = EventData.new(distance:300)
event3.save!

