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

pascal = User.create!(email: 'p@g.ch',
                    username: 'Pascal',
                    password: '12345678',
                    password_confirmation: '12345678')

didier = User.create!(email: 'd@a.ch',
                    username: 'Didier',
                    password: '12345678',
                    password_confirmation: '12345678')

peter = User.create!(email: 'p@d.ch',
                      username: 'Peter',
                      password: '12345678',
                      password_confirmation: '12345678')

# this event will be listed in the upcoming events list
event1 = Event.new(title: 'Kamikaze football Grumpel tournament sponsored by Inselspital AG',
                   description: "This football tournament is open to everyone who knows what football is. Teams consist of 5 players each (including goalkeeper). Bring your friends, bring a pack of beer. And bring shin-pads some ice because things will get ugly. We are proud to introduce the Inselspital AG as our main sponsor.",
                   owner: peter,
                   sport_id: 3,
                   location: 'Bern, Neufeld',
                   deadline: 10.seconds.from_now )
event1_date1 = event1.spoodle_dates.new(from: 30.days.from_now, to: 30.days.from_now + 2.hours)
event1_date2 = event1.spoodle_dates.new(from: 40.days.from_now, to: 40.days.from_now + 2.hours)
event1_date3 = event1.spoodle_dates.new(from: 50.days.from_now, to: 50.days.from_now + 2.hours)
event1_date4 = event1.spoodle_dates.new(from: 60.days.from_now, to: 60.days.from_now + 2.hours)
event1_date5 = event1.spoodle_dates.new(from: 70.days.from_now, to: 70.days.from_now + 2.hours)
event1_date6 = event1.spoodle_dates.new(from: 80.days.from_now, to: 80.days.from_now + 2.hours)
event1_date1.availabilities.new(user: urs, weight: 0.7)
event1_date1.availabilities.new(user: oliver, weight: 0.5)
event1_date2.availabilities.new(user: arun, weight: 1)
event1_date6.availabilities.new(user: urs, weight: 0.6)
event1_date3.availabilities.new(user: oliver, weight: 0.2)
event1_date4.availabilities.new(user: urs, weight: 1)
event1_date1.availabilities.new(user: pascal, weight: 0.7)
event1_date5.availabilities.new(user: oliver, weight: 0.3)
event1_date2.availabilities.new(user: arun, weight: 0.8)
event1_date1.availabilities.new(user: peter, weight: 0.2)
event1_date3.availabilities.new(user: urs, weight: 0.5)
event1_date4.availabilities.new(user: arun, weight: 1)
event1.invitations.new(user: urs)
event1.invitations.new(user: pascal)
event1.invitations.new(user: oliver)
event1.event_data = EventData.new( distance:100)
event1.save!

# this event will be listed in the pending events list
event2 = Event.new(title: '20th annual Bern Grand Prix',
                      description: "Some people say these are prettiest 10 miles in the world (most definitely not). The course leads through all of Bern and starts and finishes at the Guisanplatz. Bring a bottle of water!",
                      owner: peter,
                      sport_id: 1,
                      location: 'Guisanplatz',
                      deadline: 10.days.from_now )
event2_date1 = event2.spoodle_dates.new(from: 20.days.from_now, to: 20.days.from_now + 1.5.hours)
event2_date2 = event2.spoodle_dates.new(from: 30.days.from_now, to: 30.days.from_now + 1.5.hours)
event2_date1.availabilities.new(user: oliver, weight: 0.5)
event2_date2.availabilities.new(user: arun, weight: 1)
event2.invitations.new(user: arun)
event2.event_data = EventData.new(distance:200)
event2.save!

# this event will be listed in the passed events list
event3 = Event.new(title: 'EPO presents: Tour de Suisse 2014',
                   description: "This is a bicycle race for professionals. If you think you are not up to it then probably you are right. Please be aware that this event takes 2 weeks to complete.",
                   owner: urs,
                   sport_id: 2,
                   location: 'Luzern',
                   deadline: 1.seconds.from_now )
event3_date1 = event3.spoodle_dates.new(from: 2.seconds.from_now, to: 14.days.from_now)
event3_date2 = event3.spoodle_dates.new(from: 14.days.from_now, to: 28.days.from_now)
event3_date1.availabilities.new(user: oliver, weight: 0.9)
event3_date2.availabilities.new(user: oliver, weight: 0.7)
event3.invitations.new(user: peter)
event3.invitations.new(user: arun)
event3.invitations.new(user: oliver)
event3.invitations.new(user: didier)
event3.event_data = EventData.new(distance:300)
event3.save!

# this event will be listed in the pending events list
event4 = Event.new(title: 'Boxing Day tournament',
                   description: "At this free for all Boxing tournamnet everybody will get their ass kicked. The schedule consists of everyone fighting everyone. The winner of a match gets 2 points (KO) or 1 point (technical), the loser gets 0. The champions is the player with the most points at the end of the tournament. Have fun!",
                   owner: pascal,
                   sport_id: 4,
                   location: 'Bern, Kursaal',
                   deadline: 20.days.from_now )
event4_date1 = event4.spoodle_dates.new(from: 30.days.from_now, to: 30.days.from_now + 10.hours)
event4_date2 = event4.spoodle_dates.new(from: 35.days.from_now, to: 35.days.from_now + 10.hours)
event4_date1.availabilities.new(user: oliver, weight: 0.9)
event4_date1.availabilities.new(user: pascal, weight: 0.1)
event4_date1.availabilities.new(user: urs, weight: 0.5)
event4_date1.availabilities.new(user: arun, weight: 1)
event4_date1.availabilities.new(user: didier, weight: 0.3)
event4_date1.availabilities.new(user: pascal, weight: 0.7)
event4_date2.availabilities.new(user: oliver, weight: 0.7)
event4.invitations.new(user: arun)
event4.invitations.new(user: didier)
event4.invitations.new(user: peter)
event4.invitations.new(user: urs)
event4.invitations.new(user: oliver)
event4.event_data = EventData.new(distance:300)
event4.save!

# this event will be listed in the passed events list
event5 = Event.new(title: 'Gurtenlauf preparation run',
                   description: "We are running up the Gurten. This is not a proper mountain, just a little hill. In case someone isn't fit enough, they can catch the Gurtenbahn and join us at the top for a beer!",
                   owner: arun,
                   sport_id: 1,
                   location: 'Gurtenbahnstation',
                   deadline: 1.days.ago )
event5_date1 = event5.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
event5_date1.availabilities.new(user: oliver, weight: 0.9)
event5.invitations.new(user: arun)
event5.invitations.new(user: oliver)
event5.invitations.new(user: didier)
event5.invitations.new(user: urs)
event5.invitations.new(user: pascal)
event5.event_data = EventData.new(distance:300)
event5.save!

