module MockTwitter
  class Response
    def self.body(path)
      create_at = MockTwitter.starting_at
      text = MockTwitter.tweet
      in_reply_to_screen_name = MockTwitter.reply_to
      name = MockTwitter.display_name
      
      output = YAML.load_file file_path(path)
      output = case @format
        when 'xml'
          output.to_xml.sub('<hash>','').sub('</hash>','')
        when 'json'
          output.to_json
        end
      self.new.instance_eval(output)
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
        path << '.yml'

        return "#{MockTwitter.template_path}/#{path}"
      end
  end
end