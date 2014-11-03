class CybercoachResource
  @@resources_base = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources"
  @@resource_name = ""
  def initialize(hash)
    hash.each { |name, value| instance_variable_set("@#{name}", value) }
  end

  def self.get_all
    response = get_rest_response
    response.collect { |hash| CybercoachResource.new(hash)}
  end

  def self.get(id)
    all_instances = CybercoachResource.get_all
    #all_instances.select { |elem| elem.get_id = id} #need to dynamically create getters.
  end

  private
  def self.get_rest_response
    response = HTTParty.get("#{@@resources_base}/#{@@resource_name.pluralize}/",:headers => {'Accept' => 'application/json'})
    response[@@resource_name.pluralize]
  end

end