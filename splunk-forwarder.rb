require 'formula'

class SplunkForwarder < Formula
  homepage 'http://www.splunk.com'
  url 'http://www.splunk.com/page/download_track?file=4.3.4/universalforwarder/osx/splunkforwarder-4.3.4-136012-Darwin-universal.tgz&ac=&wget=true&name=wget&typed=releases'
  sha1 '7a6074edf8f67f442b9a2e853ba2912a1283731a'

  def install
    prefix.install executables
    prefix.install support_files
  end

  def test
    system 'splunk'
  end

  private

  def executables
    Dir['splunkforwarder/bin/*'] - %w(scripts setSplunkEnv)
  end

  def support_files
    Dir['splunkforwarder/{etc,lib,openssl,share}/*']
  end
end
