# https://devcenter.heroku.com/articles/scheduler
# http://graphical.weather.gov/xml/rest.php
# http://api.rubyonrails.org/classes/String.html#method-i-truncate
desc 'This task is called by the Heroku scheduler add-on'
task :update_feed => :environment do
  # coordinate_list = ''
  # if Thing.where('user_id IS NOT NULL').any?
  #     Thing.where('user_id IS NOT NULL').find_each do |thing|
  #       coordinate_list << thing.lat.to_s + ',' + thing.lng.to_s + ','
  #       # @account.sms.messages.create(:from => '+18599030353', :to => User.find(thing.user_id).sms_number, :body => User.find(thing.user_id).name + ', look out for ' + thing.name + '! Snowfall: ~' + amount + ' inches. Location: ~' + thing.full_address + '.')
  #     end
  #     
  #     @thing = Thing.new
  #     snow_amounts = @thing.get_snow_amounts(LibXML::XML::Reader.string(Net::HTTP.get(URI('http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?listLatLon=' + coordinate_list.chop + '&product=time-series&begin=' + DateTime.now.utc.new_offset(0).to_s + '&end=' + DateTime.now.utc.new_offset(0).to_s + '&snow=snow'))))
  #     snow_amounts.each do |amount|
  #       puts amount
  #     end
  #   end
  
  if Thing.where('user_id IS NOT NULL').any?
    @account_sid = 'AC0b322d7367604e7a852a1d59193738a2'
    @auth_token = 'c32bcf082cb7cee728a99832858db23b'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @thing = Thing.new
    
    Thing.where('user_id IS NOT NULL').find_each do |thing|
      snow_amounts = @thing.get_snow_amounts(LibXML::XML::Reader.string(Net::HTTP.get(URI('http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?lat=' + thing.lat.to_s + '&lon=' + thing.lng.to_s + '&product=time-series&begin=' + DateTime.now.utc.new_offset(0).to_s + '&end=' + DateTime.now.utc.new_offset(0).to_s + '&snow=snow'))))
      snow_amounts.each do |amount|
        if amount.to_i > 0.00
          @user = User.find(thing.user_id)
          extra = (101-(amount.length+thing.full_address.length))
          thing_name_length = thing.name.length
          requested = @user.name.length + thing_name_length
          if requested < extra
            @account.sms.messages.create(:from => '+18599030353', :to => @user.sms_number, :body => @user.name + ', look out for ' + thing.name + '! Forecasted snowfall: ' + amount + ' inches. Location: ' + thing.full_address + '.')
          else
            requested_extra_difference = requested-extra
            @account.sms.messages.create(:from => '+18599030353', :to => @user.sms_number, :body => @user.name + ', look out for ' + thing.name.truncate(thing_name_length-requested_extra_difference) + ' ! Forecasted snowfall: ' + amount + ' inches. Location: ' + thing.full_address + '.') if (requested > extra) && (thing_name_length > requested_extra_difference)
            # @account.sms.messages.create(:from => '+18599030353', :to => @user.sms_number, :body => @user.name.truncate(@user.name.length-(requested_extra_difference-thing_name_length)) + ', look out for ... ! Forecasted snowfall: ' + amount + ' inches. Location: ' + thing.full_address + '.') if (requested > extra) && (thing_name_length < requested_extra_difference)
          end
        end
      end
    end
  end
end