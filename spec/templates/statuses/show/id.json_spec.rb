require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe MockTwitter do
  context "when statuses/show/{id} is requested" do
    before(:each) do
      @created_at = 2.hours.ago
      @user_created_at = 2.weeks.ago
      @text = 'This is what the text should say'
      @url = 'http://codequietly.com/projects/mock-twitter'

      MockTwitter.config do |config|
        config.set :in_reply_to_user_id, 12
        config.set :created_at, @created_at
        config.set :user_statuses_count, 100
        config.set :user_description, 'I am Mock Twitter'
        config.set :user_friends_count, 1
        config.set :user_created_at, @user_created_at
        config.set :user_favourites_count, 1
        config.set :user_screen_name, 'mock_twitter'
        config.set :user_location, 'VA'
        config.set :user_name, 'Mock Twitter'
        config.set :user_id, 100
        config.set :user_followers_count, 1
        config.set :user_url, @url
        config.set :in_reply_to_screen_name, 'daneharrigan'
        config.set :in_reply_to_status_id, 101
        config.set :id, 1001
        config.set :text, @text
      end

      MockTwitter.request 'http://twitter.com/statuses/show/1000.json'
      @response = MockTwitter.response
    end

    it 'should set "in_reply_to_user_id" to 12' do
      @response.should match(/"in_reply_to_user_id":12/)
    end

    it "should set \"created_at\" to \"#{@created_at}\"" do
      @response.should match(/"created_at":"#{@created_at}"/)
    end

    it 'should set "user_statuses_count" to 100' do
      @response.should match(/"statuses_count":100/)
    end

    it 'should set "user_description" to "I am Mock Twitter"' do
      @response.should match(/"description":"I am Mock Twitter"/)
    end

    it 'should set "user_friends_count" to 1' do
      @response.should match(/"friends_count":1/)
    end

    it "should set \"user_created_at\" to \"#{@user_created_at}\"" do
      @response.should match(/"created_at":"#{@user_created_at}"/)
    end

    it 'should set "user_favourites_count" to 1' do
      @response.should match(/"favourites_count":1/)
    end

    it 'should set "user_screen_name" to "mock_twitter"' do
      @response.should match(/"screen_name":"mock_twitter"/)
    end

    it 'should set "user_location" to VA' do
      @response.should match(/"location":"VA"/)
    end

    it 'should set "user_name" to Mock Twitter' do
      @response.should match(/"name":"Mock Twitter"/)
    end

    it 'should set "user_id" to 100' do
      @response.should match(/"id":100/)
    end

    it 'should set "user_followers_count" to 1' do
      @response.should match(/"followers_count":1/)
    end

    it "should set \"user_url\" to \"#{@url}\"" do
      @response.should match(/"url":"#{@url}"/)
    end

    it 'should set "in_reply_to_screen_name" to "daneharrigan"' do
      @response.should match(/"in_reply_to_screen_name":"daneharrigan"/)
    end

    it 'should set "in_reply_to_status_id" to 101' do
      @response.should match(/"in_reply_to_status_id":101/)
    end

    it 'should set "id" to 1001' do
      @response.should match(/"id":1001/)
    end

    it "should set \"text\" to \"#{@text}\"" do
      @response.should match(/"text":"#{@text}"/)
    end
  end
end