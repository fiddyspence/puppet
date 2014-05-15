require 'puppet/ssl/base'
require 'puppet/indirector'

# Manage private and public keys as a pair.
class Puppet::SSL::Key < Puppet::SSL::Base
  wraps OpenSSL::PKey::RSA

  extend Puppet::Indirector
  indirects :key, :terminus_class => :file, :doc => <<DOC
    This indirection wraps an `OpenSSL::PKey::RSA object, representing a private key.
    The indirection key is the certificate CN (generally a hostname).
DOC

  # Because of how the format handler class is included, this
  # can't be in the base class.
  def self.supported_formats
    [:s]
  end

  # Knows how to create keys with our system defaults.
  def generate
    Puppet.info "Creating a new SSL key for #{name}"
    @content = OpenSSL::PKey::RSA.new(Puppet[:keylength].to_i)
  end

  def initialize(name)
    super
  end

end
