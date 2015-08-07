# encoding: utf-8
require "logstash/codecs/base"
require "logstash/codecs/spool"
require "logstash/json"

# This is the base class for logstash codecs.
class LogStash::Codecs::AWSConfig < LogStash::Codecs::Spool
  config_name "awsconfig"

  public
  def decode(data)
    super(LogStash::Json.load(data.force_encoding("UTF-8"))['ConfigurationItems']) do |event|
      event['@timestamp'] = event.delete('configurationItemCaptureTime')
      yield LogStash::Event.new(event)
    end
  end # def decode

end # class LogStash::Codecs::AWSConfig
