module Prep

  class Index < Jekyll::Prep

    def prepare(page)
      page.data['prepared'] = true
    end
  end
end
