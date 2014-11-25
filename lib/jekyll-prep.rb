require 'jekyll'

module Jekyll

  class PrepScript < Jekyll::Plugin
  end

  class PrepGenerator < Jekyll::Generator

    def generate(site)
      @site = site

      Dir.chdir(@site.source) do

        @script_files = Dir[File.join('_prep', '**', '*.rb')]

        run_scripts
      end
    end

    def run_scripts
      require_scripts
      scripts = instantiate_scripts

      @site.pages.each do |page|
        namespace = 'prep::' + page.path.gsub('/', '::').gsub('.md', '')
        script = scripts.detect { |script| script.class.to_s.downcase == namespace }
        script.prepare page unless script.nil?
      end
    end

    def require_scripts
      @script_files.each do |script|
        path = File.expand_path(script)
        require path
      end
    end

    def instantiate_scripts
      @site.instantiate_subclasses(Jekyll::PrepScript)
    end
  end
end
