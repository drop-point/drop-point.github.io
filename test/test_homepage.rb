# frozen_string_literal: true

require_relative './helper'

class TestHomepage < Minitest::Test
  context 'homepage' do
    setup do
      page = site.collections.pages.resources.find { |doc| doc.relative_url == '/' }
      document_root page.output
    end

    should 'content exists' do
      assert_match 'Welcome to Bridgetown!', @document_root.to_s
    end
  end
end
