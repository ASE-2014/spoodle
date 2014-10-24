require 'active_resource'
class RestUser < Api::Base

  self.prefix = '/CyberCoachServer/resources/'
  # To handle the issue with getting the resources by name (e.g. ../resources/sports/Running not ../sports/1)
  # you can set the primary_key to the created api class extending the ActiveResource::Api class.
  self.primary_key = 'username'

  # singular name of the resource. you only need to specify this if this class name is not the resource name
  self.element_name = 'user'

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['users'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end

  schema do
    string 'uri', 'username', 'password', 'realname', 'email', 'subscriptions', 'partnerships'
    integer 'publicvisible'
  end



  # Authentication for username / password combination. This will actually create a request.
  def self.rest_authenticate(username, password)
    begin
      user = find(username)
    rescue
      return nil
    end

    headers = {
        "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
        "Accept" => "text/html"
    }
    uri = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser"
    response = HTTParty.head(uri, :headers => headers)
    if response.success? then
      user
    else
      nil
    end

  end

end
