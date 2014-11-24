module Prep

  module People

    class Jill < Jekyll::PrepScript

      def prepare(page)
        page.data['prepared'] = true
      end
    end
  end
end
