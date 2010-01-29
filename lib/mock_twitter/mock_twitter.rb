module MockTwitter
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def catch_url?(path)
      @path = path.to_s.sub(/http:\/\//,'').sub(/www\./,'')
      !!@path.match('^twitter\.com[^$]')
    end

    def response(path)
      tmpl_path = file_path(path.to_s)

      if File.exists? tmpl_path
        file = File.open(tmpl_path)
        output = ''
        file.each { |line| output << line }
        return output
      else
        return 
      end
    end

    def template_path(path)
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