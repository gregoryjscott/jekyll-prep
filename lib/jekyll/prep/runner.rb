require 'jekyll'

module Jekyll
  module Prep
    class Runner < Jekyll::Generator

      def generate(site)
        @site = site
        Dir.chdir(@site.source) { prepare_pages }
      end

      def prepare_pages
        require_files
        scripts = instantiate_scripts

        @site.pages.each do |page|
          script = find_script(page, scripts)
          script.prepare(page) unless script.nil?
        end
      end

      def require_files
        files = Dir[File.join('_prep', '**', '*.rb')]
        files.each do |file|
          path = File.expand_path(file)
          require path
        end
      end

      def instantiate_scripts
        @site.instantiate_subclasses(Jekyll::Prep::Script)
      end

      def find_script(page, scripts)
        namespace = 'prep'

        path = File.dirname(page.path).gsub(File::SEPARATOR, '::')
        namespace << "::#{path}" unless path == '.'

        class_name = File.basename(page.path, '.*')
        namespace << "::#{class_name}"

        scripts.detect { |script| script.class.to_s.downcase == namespace }
      end

    end
  end
end
