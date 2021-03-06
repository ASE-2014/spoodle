class CybercoachResource
# Helps map a Cybercoach REST Resource to Ruby objects. Is meant to be extended by subclasses which follow the naming
# convention CybercoachXyz (eg. CybercoachUser) - alternatively you can configure the resource name by setting the
# instance variable @resource_name (eg. @resource_name = 'Sport')

  # Extends subclasses
  def self.inherited(base)
    base.extend(ClassMethods)
    base.instance_variable_set(:@resources_base, 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources')
    if not defined?(@fixed_path)
      splitted_name = base.name.split(/(?=[A-Z])/)
      splitted_name.shift
      resource_name = splitted_name.join
      base.instance_variable_set(:@fixed_path, resource_name)
    end
    if not defined?(@payload_root_name)
      base.instance_variable_set(:@payload_root_name, base.instance_variable_get(:@fixed_path))
    end
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

    # Creates a resource with given variable path (id's etc. depending on resource) and the attribute value pairs given in the hash
    # Username and password are optional and are necessary to create some objects
    def create(variable_path, hash, username=nil, password=nil, action=:put, payload_root_name=@payload_root_name)
      uri = "#{@resources_base}/#{@fixed_path.downcase.pluralize}/#{variable_path}"
      headers = {'Accept' => 'application/json','Content-Type' => 'application/xml'}
      if not username.nil? and not password.nil?
        headers["Authorization"] = 'Basic ' + Base64.encode64(username + ":" + password)
      end
      payload = CybercoachResource.generate_payload(payload_root_name.downcase, hash)

      HTTParty.send(action, uri, headers: headers, body: payload )
    end

    # Destroys the resource which corresponds to the given id if the username password combination is accepted
    def destroy(id, username, password)
      headers = { "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
                  "Accept" => "text/html" }
      uri = "#{@resources_base}/#{@fixed_path.downcase.pluralize}/#{id}"
      HTTParty.delete(uri, headers: headers)
    end

    private

    def get_rest_response
      response = HTTParty.get("#{@resources_base}/#{@fixed_path.downcase.pluralize}/",:headers => {'Accept' => 'application/json'})
      response[@fixed_path.downcase.pluralize]
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