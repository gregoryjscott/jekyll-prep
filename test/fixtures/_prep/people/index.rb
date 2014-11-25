module Prep

  module People

    class Index < Jekyll::Prep

      def prepare(page)
        page.data['prepared'] = true
      end
    end
  end
end
