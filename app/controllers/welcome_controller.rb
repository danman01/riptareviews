class WelcomeController < ApplicationController


  require 'mydrive.rb'

  def index
  end

  def results
    @data = MyDrive.new.get_all_data
    
    respond_to do |format|
      format.html
      format.json {render json: @data}
    end
  end
end
