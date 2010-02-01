module MockTwitter
  class Response
    def self.body(path)
      output = IO.read(file_path(path))
      output = Crack::JSON.parse(output)
      if output.is_a? Array
        tweet = output.first
        response = []
        MockTwitter.tweet_count.times { |t| response << replace_variables(tweet) }
        output = response
      else
        output = replace_variables(output)
      end

      return output
    end

    private
      def self.file_path(path)
        # get uri
        path = path.to_s.sub('http://','').sub('www.','')
        path = path.split('/')
        path.shift
        @namespace = path.first
        path = path.join('/')

        # remove/change extension
        path = path.split('.')
        @format = path.pop
        path = path.join('.')
        path << '.json'

        return "#{MockTwitter.template_path}/#{path}"
      end

      def self.replace_variables(output)
        # replace variables
        output['created_at'].sub!('@created_at', MockTwitter.starting_at) if output['created_at']
        output['text'].sub!('@text', MockTwitter.tweet) if output['text']
        output['in_reply_to_screen_name'].sub!('@in_reply_to_screen_name', MockTwitter.reply_to) if output['in_reply_to_screen_name']
        output['name'].sub!('@name', MockTwitter.display_name) if output['name']

        return output
      end
  end
end