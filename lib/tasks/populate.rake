namespace :db do
  desc "Erase and fill test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    [Meeting, Caller, Receiver].each(&:delete_all)

    i = 1000

    Caller.populate 5 do |callers|
      callers.name  = Faker::Name.first_name
      callers.number = Faker::Number.number(10)
      callers.caller_id = "call#{i}"
      i+=1
    end

    Receiver.populate 5 do |receiver|
      receiver.name  = Faker::Name.first_name
      receiver.number = Faker::Number.number(10)
      receiver.receiver_id = "call#{i}"
      i+=1
    end
    
    i = 1

    Meeting.populate 10 do |meeting|
      meeting.caller_id = Caller.all.map{|c| c.id}
      meeting.receiver_id = Receiver.all.map{|c| c.id}
      meeting.order_id = i
      meeting.duration = [15, 30, 45, 60, 75, 90]
      i+=1
    end

  end
end
