require 'formula'
require 'shellwords'

class SplunkForwarder < Formula
  homepage 'http://www.splunk.com'
  url 'http://www.splunk.com/page/download_track?file=4.3.4/universalforwarder/osx/splunkforwarder-4.3.4-136012-Darwin-universal.tgz&ac=&wget=true&name=wget&typed=releases'
  sha1 '7a6074edf8f67f442b9a2e853ba2912a1283731a'
  keg_only 'Splunk forwarder includes an invasive number of binaries and support files.'

  def caveats; <<-EOS.undent
    This formula installs a wrapper executable at #{wrapper}. The
    wrapper sets SPLUNK_HOME to #{prefix} and
    launches #{real}.
    EOS
  end

  def install
    prefix.install Dir['*']
    install_wrapper
  end

  def test
    system 'splunk'
  end

  private

  def install_wrapper
    wrapper.open 'w' do |f|
      f.puts <<-EOS.undent
        #!/bin/bash
        SPLUNK_HOME=#{prefix.to_s.shellescape}
        #{real.to_s.shellescape} "$@"
      EOS
    end
    wrapper.chmod 0755
  end

  def real
    bin.join 'splunk'
  end

  def wrapper
    HOMEBREW_PREFIX.join 'bin', 'splunk'
  end
end
