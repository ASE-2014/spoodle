require 'active_resource'
class Api::Base < ActiveResource::Base

  self.site='http://diufvm31.unifr.ch:8090'
  self.prefix = '/CyberCoachServer/resources/'

  headers['Accept'] = 'application/json'
  self.format = :json

  class << self
    def element_path(id, prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def collection_path(prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def new_element_path
      super.gsub(/.json|.xml/,'')
    end

  end
end