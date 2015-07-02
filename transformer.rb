#!/usr/bin/env ruby

require 'nokogiri'

document = Nokogiri::XML(File.read('Test List Applet.xml'))
template = Nokogiri::XSLT(File.read('repo_to_json.xslt'))

transformed_document = template.transform(document)

File.open('output.json', 'w').write(transformed_document)
