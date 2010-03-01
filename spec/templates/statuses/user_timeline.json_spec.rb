require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MockTwitter do
  context "when statuses/user_timeline is requested" do
    before(:each) do
      @created_at = 2.hours.ago
      @user_created_at = 2.weeks.ago
      @text = 'This is what the text should say'
      @url = 'http://codequietly.com/projects/mock-twitter'

      MockTwitter.config do |config|
        config.set :in_reply_to_screen_name, 'daneharrigan'
        config.set :in_reply_to_user_id, 100
        config.set :created_at, @created_at
        config.set :user_description, 'I created MockTwitter'
        config.set :user_favourites_count, 3
        config.set :user_created_at, @user_created_at
        config.set :user_statuses_count, 1001
        config.set :user_friends_count, 10
        config.set :user_location, 'VA'
        config.set :user_name, 'Dane Harrigan'
        config.set :user_followers_count, 10
        config.set :user_url, @url
        config.set :in_reply_to_status_id, 100
        config.set :id, 99
        config.set :text, @text
        config.repeat 5
      end

      MockTwitter.request 'http://twitter.com/statuses/user_timeline.json'
      @response = MockTwitter.response
    end

    it 'should set "in_reply_to_screen_name" to "daneharrigan"' do
      @response.should match(/"in_reply_to_screen_name":"daneharrigan"/)
    end

    it "should set \"created_at\" to \"#{@created_at}\"" do
      @response.should match(/"created_at":"#{@created_at}"/)
    end

    it 'should set "user_description" to "I created MockTwitter"' do
      @response.should match(/"description":"I created MockTwitter"/)
    end

    it 'should set "user_favourites_count" to 3' do
      @response.should match(/"favourites_count":3/)
    end

    it "should set \"user_created_at\" to \"#{@user_created_at}\"" do
      @response.should match(/"created_at":"#{@user_created_at}"/)
    end

    it 'should set "user_statuses_count" to 1001' do
      @response.should match(/"statuses_count":1001/)
    end

    it 'should set "user_location" to "VA"' do
      @response.should match(/"location":"VA"/)
    end

    it 'should set "user_name" to "Dane Harrigan"' do
      @response.should match(/"name":"Dane Harrigan"/)
    end

    it 'should set user "in_reply_to_user_id" to 100' do
      @response.should match(/"id":100/)
    end

    it 'should set user "in_reply_to_screen_name" to "daneharrigan"' do
      @response.should match(/"screen_name":"daneharrigan"/)
    end

    it 'should set "user_followers_count" to 10' do
      @response.should match(/"followers_count":10/)
    end

    it "should set \"user_url\" to \"#{@url}\"" do
      @response.should match(/"url":"#{@url}"/)
    end

    it 'should set "in_reply_to_status_id" to 100' do
      @response.should match(/"in_reply_to_status_id":100/)
    end

    it 'should set "id" to 99' do
      @response.should match(/"id":99/)
    end

    it "should set \"text\" to \"#{@text}\"" do
      @response.should match(/"text":"#{@text}"/)
    end

    context "when config.repeat is set" do
      it "should find my screen_name 5 times" do
        @response.scan(/"screen_name":"daneharrigan"/).length.should == 5
      end

      it 'should remove the {% repeat %} tag' do
        @response.match(/\{% repeat %\}/).should be_nil
      end

      it 'should remove the {% endrepeat %} tag' do
        @response.match(/\{% endrepeat %\}/).should be_nil
      end
    end
  end
end