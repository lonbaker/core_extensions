module ActionController
  class AbstractRequest
    def referrer
      self.env['HTTP_REFERER']
    end
  end
end
