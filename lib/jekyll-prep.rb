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
          add_to_index_items file, data unless file == '_data/index.yml'
        end
      end
    end

    def merge_data(file, data)
      path = file.gsub('_data/', '').gsub('.yml', '.md')
      page = @site.pages.detect { |page| page.path == path }
      page.data.merge! data
      page.data
    end

    def add_to_index_items(file, data)
      resource = file.match(/_data\/(?<resource>.+)\//)[1]
      path = resource + '/index.md'
      page = @site.pages.detect { |page| page.path == path }
      page.data['items'] = [] if page.data['items'].nil?
      page.data['items'].push data
    end
  end
end
