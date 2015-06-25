#!/usr/bin/env ruby

require 'yaml'
require_relative 'lib/TrelloConfig'
require_relative 'lib/TrelloMailer'

config = YAML.load(File.read('config.yml'))
config.each do |key, options|
  config = TrelloConfig.new(options)
  mailer = TrelloMailer.new(config)
  mailer.send()
end

