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

  it 'does nothing' do
  end
end
