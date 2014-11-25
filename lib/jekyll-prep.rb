require 'jekyll'

module Jekyll

  class Prep < Jekyll::Plugin
  end

  class PrepGenerator < Jekyll::Generator

    def generate(site)
      @site = site
      Dir.chdir(@site.source) { prepare_pages }
    end

    def prepare_pages
      require_files
      prep_instances = instantiate_prep

      @site.pages.each do |page|
        namespace = 'prep::' + page.path.gsub('/', '::').gsub('.md', '')
        prep = prep_instances.detect { |script| script.class.to_s.downcase == namespace }
        prep.prepare page unless prep.nil?
      end
    end

    def require_files
      files = Dir[File.join('_prep', '**', '*.rb')]
      files.each do |script|
        path = File.expand_path(script)
        require path
      end
    end

    def instantiate_prep
      @site.instantiate_subclasses(Jekyll::Prep)
    end
  end
end
