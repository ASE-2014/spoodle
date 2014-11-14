module CybercoachResource

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
    base.instance_variable_set(:@resources_base, 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources')
  end

  module InstanceMethods
    def initialize(hash)
      hash.each do |name, value|
        instance_variable_set("@#{name}", value)
        self.class.send(:attr_reader, name)
      end
    end
  end

  module ClassMethods
    def get_all
      response = get_rest_response
      response.collect {|hash| self.new(hash)}
    end

    def find_by(key, val)
      all_instances = get_all
      all_instances.select { |elem| elem.send(key) == val}
    end

    def get_rest_response
      response = HTTParty.get("#{@resources_base}/#{@resource_name.pluralize}/",:headers => {'Accept' => 'application/json'})
      response[@resource_name.pluralize]
    end

    def create(id, hash)
      uri = "#{@resources_base}/#{@resource_name.pluralize}/#{id}"
      headers = {'Accept' => 'application/json','Content-Type' => 'application/xml'}
      payload = CybercoachResource.generate_payload(@resource_name, hash)

      response = HTTParty.put(uri, headers: headers, body: payload )
    end

    def destroy(id, username, password)
      headers = { "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
                  "Accept" => "text/html" }
      uri = "#{@resources_base}/#{@resource_name.pluralize}/#{id}"
      response = HTTParty.delete(uri, headers: headers)
    end
  end

  def self.login(username, password)
    headers = { "Authorization" => 'Basic ' + Base64.encode64(username + ":" + password),
                "Accept" => "text/html" }
    uri = "#{@resources_base}/authenticateduser"
    response = HTTParty.head(uri, headers: headers)
  end

  def self.generate_payload(root, hash)
    xmlstring = "<#{root}>"
    hash.each { |key, val| xmlstring << "<#{key}>#{val}</#{key}>"}
    xmlstring << "</#{root}>"
  end

end