class WelcomeController < ApplicationController

  def index
    @tweets = $twitter.search("spoodleASE", :result_type => 'recent').take(5)
  end

end