class TweetsController < ApplicationController
  respond_to :json
  def show
    school = School.find_by_isbe params[:isbe]
    tweets = school.present? ? TwitterService.new.get_tweets_for(school, 'school') : []
    respond_with tweets
  end
end
