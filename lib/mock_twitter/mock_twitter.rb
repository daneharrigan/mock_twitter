module MockTwitter
  def self.set(index, value)
    @config = {} if @config.nil?
    @config[index] = value
  end

  def self.config
    yield self
  end

  def self.repeat(value)
    @repeat = value
  end

  def self.request(url)
    @request = url
  end

  def self.response
    if File.exists? template_path
      output = File.open(template_path).read

      if output.match(/\{% repeat %\}/) && @repeat
        repetitions = []
        match = output.match /\{% repeat %\}[^\{% endrepeat %\}](.*)\{% endrepeat %\}/m
        @repeat.times { repetitions << set_values(match[1]) }
        output.sub!(match[0], repetitions.join(','))
      end

      return set_values(output)
    end
  end

  private
  def self.set_values(output)
    @config.each do |index, value|
      output.gsub! "{{ #{index} }}", format_value(index, value.to_s)
    end
    return output
  end

  def self.template_path
    tmpl_root = File.expand_path(File.dirname(__FILE__) + '/../templates')
    uri = @request.split('twitter.com/')[1].split('.')[0]
    case uri
      when /users\/show\/[A-Za-z0-9\-_]+\z/
        uri.sub!(/[A-Za-z0-9\-_]+\z/,'id')
      when /statuses\/show\/[0-9]+\z/
        uri.sub!(/[0-9]+\z/,'id')
    end

    return "#{tmpl_root}/#{uri}.json"
  end

  def self.format_value(index, value)
    case index
      when :status_text
        unless @config[:status_in_reply_to_screen_name].nil?
          value = "@#{@config[:status_in_reply_to_screen_name]} #{value}"
        end
      else
        value
    end

    return value
  end
end