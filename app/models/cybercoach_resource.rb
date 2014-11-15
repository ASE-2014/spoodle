class CybercoachResource
# Helps map a Cybercoach REST Resource to Ruby objects. Is meant to be extended by subclasses which follow the naming convention CybercoachXyz (eg. CybercoachUser)

  # Extends subclasses
  def self.inherited(base)
    base.extend(ClassMethods)
    base.instance_variable_set(:@resources_base, 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources')
    resource_name = base.name.split(/(?=[A-Z])/)[1].downcase
    base.instance_variable_set(:@resource_name, resource_name)
  end

  # Initializes the resource with the attributes given in the hash
  def initialize(hash)
    hash.each do |name, value|
      instance_variable_set("@#{name}", value)
      self.class.send(:attr_reader, name)
    end
  end

  module ClassMethods
    # Returns all available resource elements as objects
    def get_all
      response = get_rest_response
      response.collect {|hash| self.new(hash)}
    end

    # Select resources using an attribute value pair
    def find_by(key, val)
      all_instances = get_all
      all_instances.select { |elem| elem.send(key) == val}
    end

    # Creates a resource with given id and the attribute value pairs given in the hash
    def create(id, hash)
      uri = "#{@resources_base}/#{@resource_name.pluralize}/#{id}"
      headers = {'Accept' => 'application/json','Content-Type' => 'application/xml'}
      payload = CybercoachResource.generate_payload(@resource_name, hash)

      HTTParty.put(uri, headers: headers, body: payload )
    end

    # Destroys the resource which corresponds to the given id if the username password combination is accepted
    def destroy(id, username, password)
      headers = { "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
                  "Accept" => "text/html" }
      uri = "#{@resources_base}/#{@resource_name.pluralize}/#{id}"
      HTTParty.delete(uri, headers: headers)
    end

    private
    def get_rest_response
      response = HTTParty.get("#{@resources_base}/#{@resource_name.pluralize}/",:headers => {'Accept' => 'application/json'})
      response[@resource_name.pluralize]
    end
  end

  # Logs into Cybercoach with the given username password combination
  def self.login(username, password)
    headers = { "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
                "Accept" => "text/html" }
    uri = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser"
    HTTParty.head(uri, headers: headers)
  end

  private
  # Generates an xml payload which corresponds to the given hash and has the given root argument as root element
  def self.generate_payload(root, hash)
    xmlstring = "<#{root}>"
    hash.each { |key, val| xmlstring << "<#{key}>#{val}</#{key}>"}
    xmlstring << "</#{root}>"
  end

end