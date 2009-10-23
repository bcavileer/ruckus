#!/usr/bin/env ruby

# == Introduction
# This is yet another binary formatter for Ruby; compare to bindata,
# bitstruct, or pack/unpack.
#
# Read in this order:
# * Parsel
# * Number
# * Str
# * Blob
# * Structure

module Ruckus

  # :stopdoc:
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:
  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, args.flatten)
  end

  # Utility method used to require all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))
    extensions = ::File.expand_path(::File.join(::File.dirname(fname),dir,'extensions','**','*.rb'))
    puts extensions
    spath = ::File.expand_path(::File.join(::File.dirname(fname), dir))
    Dir.glob(extensions).each{|rb| puts rb; require rb}
    require ::File.join(spath, 'parsel.rb')
    require ::File.join(spath, 'number.rb')
    require ::File.join(spath, 'str.rb')
    require ::File.join(spath, 'structure.rb')
    Dir.glob(search_me).reject{|rb| rb =~ /human_display\.rb/}.each {|rb| require rb}
    require ::File.join(spath, 'human_display.rb')
  end
end

Ruckus.require_all_libs_relative_to(__FILE__)

# require 'extensions/extensions'
# 
# %w[ parsel number ip str choice null blob filter structure dictionary
#     mutator vector mac_addr enum time_t selector dfuzz ].each do |f|
#     require 'ruckus/' + f
# end
