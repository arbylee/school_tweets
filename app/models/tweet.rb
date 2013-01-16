class Tweet
  attr_reader :screen_name, :text, :created_at
  def initialize options
    @screen_name = options[:screen_name]
    @text = options[:text]
    @created_at = options[:created_at]
  end
end
