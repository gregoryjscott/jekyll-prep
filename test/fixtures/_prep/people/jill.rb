module Prep
  module People
    class Jill < Jekyll::Prep::Script

      def prepare(page)
        page.data['prepared'] = true
      end

    end
  end
end
