require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe MockTwitter do
  context "when statuses/followers is requested" do
    before(:each) do
      @created_at = 2.hours.ago
      @status_created_at = 2.weeks.ago
      @text = 'This is what the text should say'
      @url = 'http://codequietly.com/projects/mock-twitter'

      MockTwitter.config do |config|
        config.repeat 2
        config.set :group, {
          :favourites_count => 2,
          :description => 'I am MockTwitter',
          :status_in_reply_to_user_id => 100,
          :status_in_reply_to_status_id => 100,
          :status_created_at => @status_created_at,
          :status_in_reply_to_screen_name => 'daneharrigan',
          :status_text => @text,
          :created_at => @created_at,
          :screen_name => 'mock_twitter',
          :followers_count => 2,
          :location => 'VA',
          :name => 'Mock Twitter',
          :statuses_count => 2,
          :id => 100,
          :url => @url
        }

        config.set :group, {
          :favourites_count => 2,
          :description => 'I am MockTwitter #2',
          :status_in_reply_to_user_id => 100,
          :status_in_reply_to_status_id => 100,
          :status_created_at => @status_created_at,
          :status_in_reply_to_screen_name => 'daneharrigan',
          :status_text => @text,
          :created_at => @created_at,
          :screen_name => 'mock_twitter_2',
          :followers_count => 2,
          :location => 'VA',
          :name => 'Mock Twitter #2',
          :statuses_count => 2,
          :id => 100,
          :url => @url
        }
      end

      MockTwitter.request 'http://twitter.com/statuses/followers.json'
      @response = MockTwitter.response
    end

    it 'should set "favourites_count" to 2 for both entries' do
      @response.scan(/"favourites_count":2/).length.should == 2
    end

    it 'should set "status_in_reply_to_user_id" to 100 for both entries' do
      @response.scan(/"in_reply_to_user_id":100/).length.should == 2
    end

    it 'should set "status_in_reply_to_status_id" to 100 for both entries' do
      @response.scan(/"status_in_reply_to_status_id":100/).length.should == 2
    end

    it "should set \"status_created_at\" to \"#{@status_created_at}\" for both entries" do
      @response.scan(/"created_at":"#{@status_created_at}"/).length.should == 2
    end

    it 'should set "in_reply_to_screen_name" to "daneharrigan" for both entries' do
      @response.scan(/"in_reply_to_screen_name":"daneharrigan"/).length.should == 2
    end

    it "should set \"status_text\" to \"#{@text}\" for both entries" do
      @response.scan(/"status_text":"#{@text}"/).length.should == 2
    end

    it "should set \"created_at\" to \"#{@created_at}\" for both entries" do
      @response.scan(/"created_at":"#{@created_at}"/).length.should == 2
    end

    it 'should set "followers_count" to 2 for both entries' do
      @response.scan(/"followers_count":2/).length.should == 2
    end

    it 'should set "location" to "VA" for both entries' do
      @response.scan(/"location":"VA"/).length.should == 2
    end

    it 'should set "statuses_count" to 2 for both entries' do
      @response.scan(/"statuses_count":2/).length.should == 2
    end

    it 'should set "id" to 100 for both entries' do
      @response.scan(/"id":100/).length.should == 2
    end

    it "should set \"url\" to \"#{@url}\" for both entries" do
      @response.scan(/"url":"#{@url}"/).length.should == 2
    end
    
    context "when the first set of data is processed" do
      it 'should set "description" to "I am MockTwitter"' do
        @response.should match(/"description":"I am MockTwitter"/)
      end

      it 'should set "screen_name" to "mock_twitter"' do
        @response.should match(/"screen_name":"mock_twitter"/)
      end

      it 'should set "name" to "Mock Twitter"' do
        @response.should match(/"name":"Mock Twitter"/)
      end
    end

    context "when the second set of data is processed" do
      it 'should set "description" to "I am MockTwitter #2"' do
        @response.should match(/"description":"I am MockTwitter #2"/)
      end

      it 'should set "screen_name" to "mock_twitter_2"' do
        @response.should match(/"screen_name":"mock_twitter_2"/)
      end

      it 'should set "name" to "Mock Twitter #2"' do
        @response.should match(/"name":"Mock Twitter #2"/)
      end
    end

    context "when config.repeat is set" do
      it 'should remove the {% repeat %} tag' do
        @response.match(/\{% repeat %\}/).should be_nil
      end

      it 'should remove the {% endrepeat %} tag' do
        @response.match(/\{% endrepeat %\}/).should be_nil
      end
    end
  end
end