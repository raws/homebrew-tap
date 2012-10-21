require 'formula'
require 'shellwords'

class SplunkForwarder < Formula
  homepage 'http://www.splunk.com'
  url 'http://www.splunk.com/page/download_track?file=4.3.4/universalforwarder/osx/splunkforwarder-4.3.4-136012-Darwin-universal.tgz&ac=&wget=true&name=wget&typed=releases'
  sha1 '7a6074edf8f67f442b9a2e853ba2912a1283731a'

  def install
    install_support_files
    install_executables
  end

  def test
    system 'splunk'
  end

  private

  def auxiliary_executables
    Dir['bin/*'] - %w(bin/splunk bin/scripts bin/setSplunkEnv)
  end

  def install_executables
    bin.install auxiliary_executables
    libexec.install 'bin/splunk'
    install_executable_wrapper
  end

  def install_executable_wrapper
    bin.join('splunk').tap do |wrapper|
      wrapper.open 'w' do |f|
        f.puts <<-WRAPPER
          #!/usr/bin/env SPLUNK_HOME=#{prefix.to_s.shellescape}
          #{real_executable.to_s.shellescape} "$@"
        WRAPPER
      end
      wrapper.chmod 0755
    end
  end

  def install_support_files
    prefix.install %w(etc lib openssl)
  end

  def real_executable
    libexec.join 'splunk'
  end
end
