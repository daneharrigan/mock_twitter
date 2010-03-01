module HTTParty
  class Request
    alias_method :original_perform, :perform

    def perform
      if MockTwitter.catch_url? @path
        MockTwitter.response(@path)
      else
        original_perform
      end
    end
  end
end