module MockTwitter
  class Response
    def self.body(path)
      tmpl = YAML.load_file file_path(path)
      return tmpl.to_xml.sub('<hash>','').sub('</hash>','')
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