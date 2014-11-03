# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

urs = User.create(email: 'u@z.ch',
                  username: 'Urs',
                  password: '12345678',
                  password_confirmation: '12345678')

oliver = User.create(email: 'o@s.ch',
                     username: 'Oliver',
                     password: '12345678',
                     password_confirmation: '12345678')

arun = User.create(email: 'a@s.ch',
                   username: 'Arun',
                   password: '12345678',
                   password_confirmation: '12345678')


event1 = Event.create(title: 'Best event ever',
                      description: 'This is a description',
                      owner: arun,
                      sport_id: 1
                      )

invitation_urs_event1 = event1.invitations.create(user: urs)
invitation_oli_event1 = event1.invitations.create(user: oliver)

event1_date1 = event1.spoodle_dates.create(datetime: DateTime.new(2014,10, 30))
event1_date2 = event1.spoodle_dates.create(datetime: DateTime.new(2014,11, 20),
                                           users: [oliver, urs, arun])


event2 = Event.create(title: 'Second event ever',
                      description: 'This is also a description',
                      owner: oliver,
                      sport_id: 2
                      )

invitation_oli_event2 = event2.invitations.create(user: arun)

event2_date1 = event2.spoodle_dates.create(datetime: DateTime.new(2014,12, 24))
event2_date2 = event2.spoodle_dates.create(datetime: DateTime.new(2014,12, 25))
