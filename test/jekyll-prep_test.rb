require 'jekyll-prep'
require 'minitest/autorun'

describe Jekyll::Prep do

  let(:config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'destination' => '_tmp',
      'quiet' => true
    })
  end

  let(:site) { Jekyll::Site.new(config) }
  let(:prep) { Jekyll::Prep.new() }

  before(:each) do
    site.process
  end

  it 'merges data with front matter' do
    site.pages.each do |page|
      assert_equal 'this is data', page.data['data']
      assert_equal 'this is front matter', page.data['front matter']
    end
  end

  it 'adds items to index' do
    page = site.pages.detect { |page| page.path == 'index.md' }
    assert_equal 1, page.data['items'].count

    page = site.pages.detect { |page| page.path == 'people/index.md' }
    assert_equal 2, page.data['items'].count
  end

  it 'adds url to items' do
    pages = site.pages.select { |page| page.path.end_with? 'index.md' }
    pages.each do |page|
      page.data['items'].each do |item|
        assert_instance_of String, item['url']
      end
    end
  end
end
