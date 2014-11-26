module Prep

  class Index < Jekyll::Prep::Script

    def prepare(page)
      page.data['prepared'] = true
    end
  end
end
