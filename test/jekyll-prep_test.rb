require 'jekyll-prep'
require 'minitest/autorun'

describe 'Prep' do

  let(:config) do
    Jekyll.configuration({
      'source' => 'test/fixtures',
      'permalink' => 'pretty',
      'quiet' => true
    })
  end

  let(:site) { Jekyll::Site.new(config) }

  before(:each) do
    site.process
  end

  it 'runs scripts for item pages' do
    page = site.pages.detect { |page| page.path == 'people/jill.md' }
    assert_equal true, page.data['prepared']
  end

  it 'runs scripts for index pages' do
    page = site.pages.detect { |page| page.path == 'people/index.md' }
    assert_equal true, page.data['prepared']
  end
end
