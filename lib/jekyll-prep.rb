require 'find'
require 'jekyll'

module Jekyll

  class PrepScript < Jekyll::Plugin
  end

  class PrepGenerator < Jekyll::Generator

    def generate(site)
      @site = site

      Dir.chdir(@site.source) do

        @data_files = Dir[File.join('_data', '**', '*.yml')]
        @script_files = Dir[File.join('_prep', '**', '*.rb')]

        load_data
        run_scripts
      end
    end

    def load_data
      @data_files.each do |data_file|
        data = YAML.load_file(data_file)
        data = merge_data data_file, data
        add_to_index data_file, data unless is_index data_file
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

    def merge_data(data_file, data)
      path = data_file.gsub('_data/', '').gsub('.yml', '.md')
      page = @site.pages.detect { |page| page.path == path }
      page.data.merge! data
      page.data['url'] = page.url
      page.data
    end

    def add_to_index(data_file, data)
      page = find_corresponding_index data_file
      page.data['items'] = [] if page.data['items'].nil?
      page.data['items'].push data
    end

    def find_corresponding_index(data_file)
      path = 'index.md'
      nesting = data_file.match(/_data\/(?<resource>.+)\//)
      path = File.join nesting[1], path unless nesting.nil?
      page = @site.pages.detect { |page| page.path == path }
    end

    def is_index(data_file)
      data_file.end_with? 'index.yml'
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
