module MockTwitter
  @@screen_name = 'mock_twitter'
  @@display_name = 'Mock Twitter'
  @@starting_at = 2.minutes.ago
  @@duration = 2.minutes
  @@tweet_count = 5
  @@reply_to = nil

  def self.config
    yield self
  end

  def self.screen_name(value=nil)
    return @@screen_name if value.nil?
    @@screen_name = value
  end

  def self.display_name(value=nil)
    return @@display_name if value.nil?
    @@display_name = value
  end

  def self.starting_at(value=nil)
    return @@starting_at if value.nil?
    @@starting_at = value
  end

  def self.duration(value=nil)
    return @@duration if value.nil?
    @@duration = value
  end

  def self.tweet_count(value=nil)
    return @@tweet_count if value.nil?
    @@tweet_count = value
  end

  def self.reply_to(value=nil)
    return @@reply_to if value.nil?
    @@reply_to = value
  end

  def self.tweet
    Lorem::Base.new('chars', 140).output
  end


  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def catch_url?(path)
      @path = path.to_s.sub(/http:\/\//,'').sub(/www\./,'')
      !!@path.match('^twitter\.com[^$]')
    end

    def response(path)
      return Response.body(path)
      #tmpl_path = file_path(path.to_s)

      #if File.exists? tmpl_path
      #  file = File.open(tmpl_path)
      #  output = ''
      #  file.each { |line| output << line }
      #  return output
      #else
      #  return 
      #end
    end

    def template_path(path=nil)
      return @template_path if path.nil?
      @template_path = path
    end

    private
      def file_path(path)
        # get uri
        path = @path.split('/')
        path.shift # remove domain
        path = path.join('/')

        # remove/change extension
        path = path.split('.')
        path.pop
        path << '.tmpl'

        return "#{@template_path}/#{path}"
      end
  
      def error_response
        return 'Whoa! That page doesn\'t exist'
      end
  end

  class Basement
    include MockTwitter
  end

  def self.catch_url?(*args)
    Basement.catch_url?(*args)
  end

  def self.response(*args)
    Basement.response(*args)
  end

  def self.template_path(*args)
    Basement.template_path(*args)
  end
end