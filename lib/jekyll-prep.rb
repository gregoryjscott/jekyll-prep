require 'find'
require 'jekyll'

module Jekyll

  class Prep < Jekyll::Generator

    def generate(site)

      # Run everything from the source directory.
      Dir.chdir(site.source) do
        files = Dir['_data/**/*.yml']
        files.each do |file|
          data = YAML.load_file(file)
          data = update_item site, file, data
          update_index site, file, data unless file == '_data/index.yml'
        end
      end
    end

    def update_item(site, file, data)
      page.data['resource_name'] = page.name.gsub('.md', '')

      # Merge data into its corresponding page.
      path = file.gsub('_data/', '').gsub('.yml', '.md')
      page = site.pages.detect { |page| page.path == path }
      page.data.merge! data

      # Add parent fields to data.
      unless file == '_data/index.yml'
        resource = file.match(/_data\/(?<resource>.+)\//)[1]
        page.data['parent_name'] = resource
        page.data['parent_url'] = "/#{resource}"
      end

      # Return the merged data.
      page.data
    end

    def update_index(site, file, data)
      resource = file.match(/_data\/(?<resource>.+)\//)[1]
      page.data['resource_name'] = resource

      # Add array of items to index page.
      path = resource + '/index.md'
      page = site.pages.detect { |page| page.path == path }
      page.data['items'] = [] if page.data['items'].nil?
      page.data['items'].push data
    end
  end
end
