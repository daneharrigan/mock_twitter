require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe MockTwitter do
  context "when users/show/{id} is requested" do
    before(:each) do
      @created_at = 2.hours.ago
      @status_created_at = 2.weeks.ago
      @status_text = 'This is what the text should say'
      @url = 'http://codequietly.com/projects/mock-twitter'

      MockTwitter.config do |config|
        config.set :friends_count, 32
        config.set :description, 'I am Mock Twitter'
        config.set :status_created_at, @status_created_at
        config.set :status_in_reply_to_user_id, 10
        config.set :status_in_reply_to_screen_name, 'Reply_ScreenName'
        config.set :status_id, 101
        config.set :status_in_reply_to_status_id, 102
        config.set :status_text, @status_text
        config.set :favourites_count, 12
        config.set :created_at, @created_at
        config.set :screen_name, 'mock_twitter'
        config.set :location, 'VA'
        config.set :name, 'Mock Twitter'
        config.set :url, @url
      end

      MockTwitter.request 'http://twitter.com/users/show/mock_twitter.json'
      @response = MockTwitter.response
    end

    it 'should set "friends_count" to 32' do
      @response.should match(/"friends_count":32/)
    end

    it 'should set "description" to "I am Mock Twitter"' do
      @response.should match(/"description":"I am Mock Twitter"/)
    end

    it "should set \"status_created_at\" to \"#{@status_created_at}\"" do
      @response.should match(/"created_at":"#{@status_created_at}"/)
    end

    it 'should set "status_in_reply_to_user_id" to 10' do
      @response.should match(/"in_reply_to_user_id":10/)
    end

    it 'should set "status_in_reply_to_screen_name" to "Reply_ScreenName"' do
      @response.should match(/"in_reply_to_screen_name":"Reply_ScreenName"/)
    end

    it 'should set "status_id" to 101' do
      @response.should match(/"id":101/)
    end

    it 'should set "status_in_reply_to_status_id" to 102' do
      @response.should match(/"in_reply_to_status_id":102/)
    end

    it "should set \"status_text\" to \"#{@status_text}\"" do
      @response.should match(/"text":"@Reply_ScreenName #{@status_text}"/)
    end

    it 'should set "favourites_count" to 12' do
      @response.should match(/"favourites_count":12/)
    end

    it "should set \"created_at\" to \"#{@created_at}\"" do
      @response.should match(/"created_at":"#{@created_at}"/)
    end

    it 'should set "screen_name" to "mock_twitter"' do
      @response.should match(/"screen_name":"mock_twitter"/)
    end

    it 'should set "location" to VA' do
      @response.should match(/"location":"VA"/)
    end

    it 'should set "name" to "Mock Twitter"' do
      @response.should match(/"name":"Mock Twitter"/)
    end

    it "should set \"url\" to \"#{@url}\"" do
      @response.should match(/"url":"#{@url}"/)
    end
  end
end