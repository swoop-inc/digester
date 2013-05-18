require 'active_support/core_ext'
require 'digest/md5'

module Digester
  class Digester

    DEFAULT_NAMESPACE = ''
    DEFAULT_SEPARATOR = '::'

    attr_accessor :options

    # Creates a digester using a set of options.
    #
    # @option opts [String] :namespace ('') The namespace for the digests
    # @option opts [String] :separator ('::') Internal separator between data structure elements
    # @option opts [String] :sort (false) Should data structure
    #   elements be sorted before a digest is computed. Note that this could make two
    #   different data structures produce the same digest but it is useful in some cases.
    # @option opts [String] :uniquify (false) Should data structure
    #   elements be uniquified before a digest is computed. Note that this could make two
    #   different data structures produce the same digest but it is useful in some cases.
    # @option opts [String] :upcase (false) Should the MD5 digest be upcased?
    def initialize(opts = {})
      @options = self.class.options_from opts
    end

    # Creates an MD5 digest of its arguments.
    # The data structures cannot have any circular references.
    #
    # @return [String] MD5 digest
    def digest(*args)
      self.class.digest(args, options)
    end

    # Creates an MD5 digest for a tree data structure.
    # The data structure cannot have any circular references.
    #
    # @param args [Object] the data to digest
    # @option opts [String] :namespace ('') The namespace for the digests.
    #   This allows different digests for the same data structures used in different contexts.
    # @option opts [String] :separator ('::') Internal separator between data structure elements.
    #   This is an aid in ensuring different data structures generate different digests.
    # @option opts [String] :sort (false) Should data structure
    #   elements be sorted before a digest is computed. Note that this could make two
    #   different data structures produce the same digest but it is useful in some cases.
    # @option opts [String] :uniquify (false) Should data structure
    #   elements be uniquified before a digest is computed. Note that this could make two
    #   different data structures produce the same digest but it is useful in some cases.
    # @option opts [String] :upcase (false) Should the MD5 digest be upcased?
    # @return [String] MD5 digest
    def self.digest(args, opts = {})
      opts = options_from opts
      args = Array.wrap(args).flatten.map(&:to_s)
      args.uniq! if opts[:uniquify]
      args.sort! if opts[:sort]
      content = args.join(opts[:separator])
      digest = ::Digest::MD5.hexdigest(content)
      digest.upcase! if opts[:upcase]
      if opts[:namespace].blank?
        digest
      else
        namespace = opts[:namespace]
        namespace.upcase! if opts[:upcase]
        "#{namespace}:#{digest}"
      end
    end

    protected

    def self.options_from(opts)
      opts.reverse_merge default_opts
    end

    def self.default_opts
      {
          namespace: DEFAULT_NAMESPACE,
          separator: DEFAULT_SEPARATOR,
          sort: false,
          uniquify: false,
          upcase: false
      }
    end

  end
end
