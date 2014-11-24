require 'find'
require 'jekyll'

module Jekyll

  class Prep < Jekyll::Generator

    def generate(site)
      @site = site
      Dir.chdir(site.source) do
        files = Dir['_data/**/*.yml']
        files.each do |file|
          data = YAML.load_file(file)
          data = merge_data file, data
          add_to_index file, data unless is_index file
        end
      end
    end

    private

    def merge_data(file, data)
      path = file.gsub('_data/', '').gsub('.yml', '.md')
      page = @site.pages.detect { |page| page.path == path }
      page.data.merge! data
      page.data['url'] = page.url
      page.data
    end

    def add_to_index(file, data)
      page = find_corresponding_index file
      page.data['items'] = [] if page.data['items'].nil?
      page.data['items'].push data
    end

    def find_corresponding_index(file)
      path = 'index.md'
      nesting = file.match(/_data\/(?<resource>.+)\//)
      path = File.join nesting[1], path unless nesting.nil?
      page = @site.pages.detect { |page| page.path == path }
    end

    def is_index(file)
      file.end_with? 'index.yml'
    end
  end
end
