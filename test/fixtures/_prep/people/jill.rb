module Prep

  module People

    class Jill < Jekyll::Prep

      def prepare(page)
        page.data['prepared'] = true
      end
    end
  end
end
