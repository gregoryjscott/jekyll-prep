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
    site.pages.each do |page|
      assert_instance_of Fixnum, page.data['age']
    end
  end
end
