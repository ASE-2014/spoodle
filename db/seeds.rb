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


event1 = Event.new(title: 'Best event ever',
                      description: 'This is a description',
                      owner: arun,
                      sport_id: 1,
                      deadline: DateTime.now.end_of_day )
event1_date1 = event1.spoodle_dates.new(datetime: 3.days.from_now)
event1_date2 = event1.spoodle_dates.new(datetime: 4.days.from_now, users: [oliver, urs, arun ] )
event1_inv1 = event1.invitations.new(user: urs)
event1_inv2 = event1.invitations.new(user: oliver)
event1.save!


event2 = Event.new(title: 'Second event ever',
                      description: 'This is also a description',
                      owner: oliver,
                      sport_id: 2,
                      deadline: 15.minutes.from_now )
event2_date1 = event2.spoodle_dates.new(datetime: 10.days.from_now)
event2_date2 = event2.spoodle_dates.new(datetime: 5.days.from_now)
event2_inv2 = event2.invitations.new(user: arun)
event2.save!