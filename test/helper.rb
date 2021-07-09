# frozen_string_literal: true

require 'nokogiri'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/profile'
require 'shoulda'
require 'rails-dom-testing'

unless ENV['RM_INFO']
  Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
end

Minitest::Test.class_eval do
  include Rails::Dom::Testing::Assertions

  def site
    @site ||= Bridgetown.sites.first
  end

  def nokogiri(input)
    input.respond_to?(:output) ? Nokogiri::HTML(input.output) : Nokogiri::HTML(input)
  end

  def document_root(root)
    @document_root = root.is_a?(Nokogiri::XML::Document) ? root : nokogiri(root)
  end

  def document_root_element
    raise 'Call `document_root` with a Nokogiri document before testing your assertions' if @document_root.nil?

    @document_root
  end
end
