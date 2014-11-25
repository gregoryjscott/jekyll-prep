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

  it 'prepares root index page' do
    page = site.pages.detect { |page| page.path == 'index.md' }
    assert_equal true, page.data['prepared']
  end

  it 'prepares root pages' do
    page = site.pages.detect { |page| page.path == 'about.md' }
    assert_equal true, page.data['prepared']
  end

  it 'prepares nested index page' do
    page = site.pages.detect { |page| page.path == 'people/index.md' }
    assert_equal true, page.data['prepared']
  end

  it 'prepares nested pages' do
    page = site.pages.detect { |page| page.path == 'people/jill.md' }
    assert_equal true, page.data['prepared']
  end

  it 'leaves other pages alone' do
    page = site.pages.detect { |page| page.path == 'people/jack.md' }
    assert_equal false, page.data['prepared']
  end
end
