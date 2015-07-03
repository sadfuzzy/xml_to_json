#!/usr/bin/env ruby

# Variant 1

# require 'active_support'
# require 'active_support/core_ext'

# xml = File.read('Test List Applet.xml')
# transformed_document = Hash.from_xml(xml).to_json
# File.open('output.json', 'w').write(transformed_document)

# Variant 2

require 'json'
require 'nokogiri'

document = Nokogiri::XML(File.read('Test List Applet.xml'))
template = Nokogiri::XSLT(File.read('repo_to_json.xslt'))

transformed_document = template.transform(document)
