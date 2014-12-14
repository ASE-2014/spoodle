# ruby encoding: utf-8

########################################################################################################################
#####                                                  Users                                                       #####
########################################################################################################################
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

peter = User.create!(email: 'p@e.ch',
                      username: 'Peter',
                      password: '12345678',
                      password_confirmation: '12345678')

henry = User.create!(email: 'h@e.ch',
                     username: 'Henry',
                     password: '12345678',
                     password_confirmation: '12345678')

karl = User.create!(email: 'k@a.ch',
                     username: 'Karl',
                     password: '12345678',
                     password_confirmation: '12345678')

sandra = User.create!(email: 's@a.ch',
                     username: 'Sandra',
                     password: '12345678',
                     password_confirmation: '12345678')

anna = User.create!(email: 'a@n.ch',
                     username: 'Anna',
                     password: '12345678',
                     password_confirmation: '12345678')

stefanie = User.create!(email: 's@t.ch',
                     username: 'Stefanie',
                     password: '12345678',
                     password_confirmation: '12345678')

########################################################################################################################
#####                                                  Events                                                      #####
########################################################################################################################

########################################################################################################################
# Event 1, upcoming

event1 = Event.new(title: 'Kamikaze football Grumpel tournament sponsored by Inselspital AG',
                   description: "This football tournament is open to everyone who knows what football is. Teams consist of 5 players each (including goalkeeper). Bring your friends, bring a pack of beer. And bring shin-pads some ice because things will get ugly. We are proud to introduce the Inselspital AG as our main sponsor.",
                   owner: peter,
                   sport_id: 3,
                   location: 'Bern, Neufeld',
                   deadline: 10.seconds.from_now )

# SpoodleDates
event1_date1 = event1.spoodle_dates.new(from: 4.days.from_now,            to: 4.days.from_now + 2.hours)
event1_date2 = event1.spoodle_dates.new(from: 4.days.from_now + 4.hours,  to: 4.days.from_now + 6.hours)
event1_date3 = event1.spoodle_dates.new(from: 4.days.from_now + 8.hours,  to: 4.days.from_now + 10.hours)
event1_date4 = event1.spoodle_dates.new(from: 5.days.from_now,            to: 5.days.from_now + 2.hours)
event1_date5 = event1.spoodle_dates.new(from: 5.days.from_now + 4.hours,  to: 5.days.from_now + 6.hours)
event1_date6 = event1.spoodle_dates.new(from: 6.days.from_now,            to: 6.days.from_now + 2.hours)

# Invitations
event1.invitations.new(user: urs)
event1.invitations.new(user: pascal)
event1.invitations.new(user: oliver)
event1.invitations.new(user: stefanie)
event1.invitations.new(user: anna)
event1.invitations.new(user: karl)

# Availabilities
event1_date1.availabilities.new(user: urs, weight: 0.7)
event1_date1.availabilities.new(user: oliver, weight: 0.5)
event1_date1.availabilities.new(user: peter, weight: 1)
event1_date1.availabilities.new(user: pascal, weight: 0.7)

event1_date2.availabilities.new(user: peter, weight: 1)
event1_date2.availabilities.new(user: arun, weight: 1)

event1_date3.availabilities.new(user: peter, weight: 1)
event1_date3.availabilities.new(user: oliver, weight: 0.2)
event1_date3.availabilities.new(user: urs, weight: 0.5)

event1_date4.availabilities.new(user: peter, weight: 0.5)
event1_date4.availabilities.new(user: urs, weight: 0.1)
event1_date4.availabilities.new(user: arun, weight: 1)

event1_date5.availabilities.new(user: peter, weight: 0.6)
event1_date5.availabilities.new(user: oliver, weight: 0.3)

event1_date6.availabilities.new(user: peter, weight: 1)
event1_date6.availabilities.new(user: urs, weight: 0.6)
event1_date6.availabilities.new(user: stefanie, weight: 0.1)

event1.save!

########################################################################################################################
# Event 2, pending

event2 = Event.new(title: '20th annual Bern Grand Prix',
                      description: "Some people say these are prettiest 10 miles in the world (most definitely not). The course leads through all of Bern and starts and finishes at the Guisanplatz. Bring a bottle of water!",
                      owner: oliver,
                      sport_id: 1,
                      location: 'Guisanplatz, Bern',
                      deadline: 10.days.from_now )

# SpoodleDates
event2_date1 = event2.spoodle_dates.new(from: 20.days.from_now, to: 20.days.from_now + 1.5.hours)
event2_date2 = event2.spoodle_dates.new(from: 21.days.from_now, to: 21.days.from_now + 1.5.hours)
event2_date3 = event2.spoodle_dates.new(from: 24.days.from_now, to: 24.days.from_now + 1.5.hours)
event2_date4 = event2.spoodle_dates.new(from: 25.days.from_now, to: 25.days.from_now + 1.5.hours)
event2_date5 = event2.spoodle_dates.new(from: 29.days.from_now, to: 29.days.from_now + 1.5.hours)
event2_date6 = event2.spoodle_dates.new(from: 30.days.from_now, to: 30.days.from_now + 1.5.hours)

# Invitations
event2.invitations.new(user: arun)
event2.invitations.new(user: didier)
event2.invitations.new(user: urs)
event2.invitations.new(user: henry)
event2.invitations.new(user: stefanie)
event2.invitations.new(user: sandra)
event1.invitations.new(user: pascal)

# Availabilities
event2_date1.availabilities.new(user: oliver, weight: 1)
event2_date1.availabilities.new(user: sandra, weight: 0.9)

event2_date2.availabilities.new(user: oliver, weight: 0.2)
event2_date2.availabilities.new(user: arun, weight: 1)

event2_date3.availabilities.new(user: oliver, weight: 0.3)
event2_date3.availabilities.new(user: stefanie, weight: 1)

event2_date4.availabilities.new(user: oliver, weight: 0.1)
event2_date4.availabilities.new(user: sandra, weight: 0.8)

event2_date5.availabilities.new(user: oliver, weight: 0.5)
event2_date5.availabilities.new(user: sandra, weight: 0.3)

event2_date6.availabilities.new(user: oliver, weight: 0.1)
event2_date6.availabilities.new(user: sandra, weight: 1)

event2.save!

########################################################################################################################
# Event 3, upcoming

event3 = Event.new(title: 'EPO presents: Tour de Suisse 2014',
                   description: "This is a bicycle race for professionals. If you think you are not up to it then probably you are right. Please be aware that this event takes 2 days to complete.",
                   owner: urs,
                   sport_id: 2,
                   location: 'Luzern',
                   deadline: 10.seconds.from_now )

# SpoodleDates
event3_date1 = event3.spoodle_dates.new(from: 2.days.from_now, to: 4.days.from_now)
event3_date2 = event3.spoodle_dates.new(from: 4.days.from_now, to: 6.days.from_now)
event3_date3 = event3.spoodle_dates.new(from: 6.days.from_now, to: 8.days.from_now)

# Invitations
event3.invitations.new(user: peter)
event3.invitations.new(user: arun)
event3.invitations.new(user: oliver)
event3.invitations.new(user: didier)
event3.invitations.new(user: anna)
event3.invitations.new(user: karl)

# Availabilities
event3_date1.availabilities.new(user: oliver, weight: 0.9)
event3_date1.availabilities.new(user: urs, weight: 0.8)

event3_date2.availabilities.new(user: oliver, weight: 0.7)
event3_date2.availabilities.new(user: urs, weight: 1)
event3_date2.availabilities.new(user: anna, weight: 1)

event3_date3.availabilities.new(user: karl, weight: 1)
event3_date3.availabilities.new(user: urs, weight: 0.7)

event3.save!

########################################################################################################################
# Event 4, pending

event4 = Event.new(title: 'Boxing Day tournament',
                   description: "At this free for all Boxing tournamnet everybody will get their ass kicked. The schedule consists of everyone fighting everyone. The winner of a match gets 2 points (KO) or 1 point (technical), the loser gets 0. The champions is the player with the most points at the end of the tournament. Have fun!",
                   owner: pascal,
                   sport_id: 4,
                   location: 'Bern, Kursaal',
                   deadline: 20.days.from_now )

# SpoodleDates
event4_date1 = event4.spoodle_dates.new(from: 30.days.from_now, to: 30.days.from_now + 10.hours)
event4_date2 = event4.spoodle_dates.new(from: 35.days.from_now, to: 35.days.from_now + 10.hours)

# Invitations
event4.invitations.new(user: arun)
event4.invitations.new(user: didier)
event4.invitations.new(user: peter)
event4.invitations.new(user: urs)
event4.invitations.new(user: oliver)
event4.invitations.new(user: karl)
event4.invitations.new(user: peter)
event4.invitations.new(user: anna)
event4.invitations.new(user: stefanie)
event4.invitations.new(user: sandra)

# Availabilities
event4_date1.availabilities.new(user: oliver, weight: 0.9)
event4_date1.availabilities.new(user: pascal, weight: 0.1)
event4_date1.availabilities.new(user: urs, weight: 0.5)
event4_date1.availabilities.new(user: arun, weight: 1)
event4_date1.availabilities.new(user: didier, weight: 0.3)
event4_date1.availabilities.new(user: pascal, weight: 0.7)

event4_date2.availabilities.new(user: oliver, weight: 0.7)
event4_date2.availabilities.new(user: anna, weight: 0.7)
event4_date2.availabilities.new(user: peter, weight: 1)

event4.save!

########################################################################################################################
# Event 5, passed

event5 = Event.new(title: 'Gurtenlauf preparation run',
                   description: "We are running up the Gurten. This is not a proper mountain, just a little hill. In case someone isn't fit enough, they can catch the Gurtenbahn and join us at the top for a beer!",
                   owner: arun,
                   sport_id: 1,
                   location: 'Gurtenbahnstation',
                   deadline: 1.days.ago )

# SpoodleDates
event5_date1 = event5.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)

# Invitations
event5.invitations.new(user: arun)
event5.invitations.new(user: oliver)
event5.invitations.new(user: didier)
event5.invitations.new(user: urs)
event5.invitations.new(user: pascal)
event5.invitations.new(user: anna)
event5.invitations.new(user: sandra)
event5.invitations.new(user: karl)

# Availabilities
event5_date1.availabilities.new(user: oliver, weight: 0.9)
event5_date1.availabilities.new(user: anna, weight: 0.9)
event5_date1.availabilities.new(user: urs, weight: 0.9)
event5_date1.availabilities.new(user: karl, weight: 0.9)
event5_date1.availabilities.new(user: sandra, weight: 0.9)
event5_date1.availabilities.new(user: didier, weight: 0.9)

# EventData
event5.event_data = EventData.new(distance:300)

event5.save!

########################################################################################################################

# event6 = Event.new(title: 'Quick dummy passed boxing event', description: "bla", owner: peter, sport_id: 4, location: 'Bern', deadline: 1.days.ago )
# event6_date1 = event6.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event6_date1.availabilities.new(user: peter, weight: 1)
# event6.save!
#
# event7 = Event.new(title: 'Quick dummy passed soccer event', description: "bla", owner: peter, sport_id: 3, location: 'Bern', deadline: 1.days.ago )
# event7_date1 = event7.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event7_date1.availabilities.new(user: peter, weight: 1)
# event7.save!
#
# event8 = Event.new(title: 'Quick dummy passed cycling event', description: "bla", owner: peter, sport_id: 2, location: 'Bern', deadline: 1.days.ago )
# event8_date1 = event8.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event8_date1.availabilities.new(user: peter, weight: 1)
# event8.save!
#
# event9 = Event.new(title: 'Quick dummy passed running event', description: "bla", owner: peter, sport_id: 1, location: 'Bern', deadline: 1.days.ago )
# event9_date1 = event9.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event9_date1.availabilities.new(user: peter, weight: 1)
# event9.save!
#
# event10 = Event.new(title: 'Quick dummy passed soccer event', description: "bla", owner: peter, sport_id: 3, location: 'Bern', deadline: 1.days.ago )
# event10_date1 = event10.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event10_date1.availabilities.new(user: peter, weight: 1)
# event10.save!
#
# event11 = Event.new(title: 'Quick dummy passed running event', description: "bla", owner: peter, sport_id: 1, location: 'Bern', deadline: 1.days.ago )
# event11_date1 = event11.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event11_date1.availabilities.new(user: peter, weight: 1)
# event11.save!
#
# event12 = Event.new(title: 'Quick dummy passed cycling event', description: "bla", owner: peter, sport_id: 2, location: 'Bern', deadline: 1.days.ago )
# event12_date1 = event12.spoodle_dates.new(from: 11.hours.ago, to: 1.hours.ago)
# event12_date1.availabilities.new(user: peter, weight: 1)
# event12.save!
