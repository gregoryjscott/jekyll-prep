require 'jekyll-prep'
require 'minitest/autorun'

describe Jekyll::Prep do

  let(:config) do
    Jekyll.configuration({
      'source'      => 'test/fixtures',
      'destination' => '_tmp'
    })
  end

  let(:site) { Jekyll::Site.new(config) }
  let(:prep) { Jekyll::Prep.new() }

  before(:each) do
    site.process
  end

  it 'merges data with front matter' do
    pages = site.pages.select { |page| page.name != 'index.md' }
    pages.each do |page|
      assert_instance_of Fixnum, page.data['age']
    end
  end

  it 'adds items to index page' do
    page = site.pages.detect { |page| page.name == 'index.md' }
    assert page.data['items'].count == 2
  end

  it 'adds url to data items' do
    page = site.pages.detect { |page| page.name == 'index.md' }
    page.data['items'].each do |item|
      assert_instance_of String, item['url']
    end
  end
end
