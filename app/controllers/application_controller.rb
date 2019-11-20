class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def hello
    render html: "<h1>What is up with you nigga</h1>"
  end
end
