module Prep

  class About < Jekyll::Prep

    def prepare(page)
      page.data['prepared'] = true
    end
  end
end
