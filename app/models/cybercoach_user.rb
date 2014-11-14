class CybercoachUser
  include CybercoachResource
  @resource_name = 'user'

  def self.create(username, email, password)
    uri = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/#{username}"
    headers = {'Accept' => 'application/json','Content-Type' => 'application/xml'}
    payload = "<user><email>#{email}</email>" +
        "<password>#{password}</password>" +
        "<publicvisible>2</publicvisible>" +
        "<realname>#{username}</realname></user>"

    response = HTTParty.put(uri, headers: headers, body: payload )
  end
end