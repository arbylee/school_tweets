class SchoolsController < ApplicationController
  respond_to :html, :json
  def index
    @schools = School.order("name").all
    respond_with @schools
  end

  def show
    @school = School.find params[:id]
    @tweets = TwitterService.new.get_tweets_for(@school, "school")
  end
end
