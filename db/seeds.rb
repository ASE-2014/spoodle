# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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


event1 = Event.new(title: 'Best event ever',
                      description: 'This is a description',
                      owner: arun,
                      sport_id: 1,
                      deadline: 2.days.from_now )
event1.spoodle_dates.new(from: 3.days.from_now, to: 3.days.from_now + 2.hours)
event1.spoodle_dates.new(from: 4.days.from_now, to: 4.days.from_now + 2.hours, users: [oliver, urs, arun ] )
event1.invitations.new(user: urs)
event1.invitations.new(user: oliver)
event1.save!


event2 = Event.new(title: 'Second event ever',
                      description: 'This is also a description',
                      owner: oliver,
                      sport_id: 2,
                      deadline: 15.minutes.from_now )
event2.spoodle_dates.new(from: 7.days.from_now, to: 7.days.from_now + 1.hour, weight: 0.5)
event2.spoodle_dates.new(from: 5.days.from_now, to: 5.days.from_now + 30.minutes)
event2.invitations.new(user: arun)
event2.save!