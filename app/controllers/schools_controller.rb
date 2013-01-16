class SchoolsController < ApplicationController
  def index
    @schools = School.order("name").all
  end

  def show
    @school = School.find params[:id]
    @tweets = TwitterService.new.get_tweets_for(@school, "school")
  end
end
