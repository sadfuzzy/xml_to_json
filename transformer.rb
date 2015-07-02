#!/usr/bin/env ruby
require 'active_support'
require 'active_support/core_ext'

xml = File.read('Test List Applet.xml')
transformed_document = Hash.from_xml(xml).to_json
File.open('output.json', 'w').write(transformed_document)
