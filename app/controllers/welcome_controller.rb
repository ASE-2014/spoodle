class WelcomeController < ApplicationController
  def index
    @tweets = $twitter.search("spoodle", :result_type => 'recent').take(10)
  end
end