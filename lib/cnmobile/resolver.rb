module Cnmobile
  class Resolver < ActionView::FileSystemResolver
    EXTENSION_ORDER = [:mobile, :locale, :formats, :handlers]
    
    # for rails 3.0.x
    def initialize(path) 
      raise ArgumentError, "path already is a Resolver class" if path.is_a?(Resolver)
      super(path)
      @path = File.expand_path(path)
    end
    
    private
    def find_templates(name, prefix, partial, details)
      path = build_path(name, prefix, partial, details)
      query(path, EXTENSION_ORDER.map { |ext| details[ext] }, details[:formats])
    end

    def query(path, exts, formats)
      query = File.join(@path, path)

      exts.each do |ext|
        query << '{' << ext.map {|e| e && ".#{e}" }.join(',') << ',}'
      end

      query.gsub!(/\{\.html,/, "{.html,.text.html,")
      query.gsub!(/\{\.text,/, "{.text,.text.plain,")
      query.gsub!(/\{\.mobile,/, "{_mobile")
      Dir[query].reject { |p| File.directory?(p) }.map do |p|
        handler, format = extract_handler_and_format(p, formats)

        contents = File.open(p, "rb") {|io| io.read }
        variant = p.match(/.+#{path}(.+)\.#{format.to_sym.to_s}.*$/) ? $1 : ''
        virtual_path = variant.blank? ? path : path + variant
        ActionView::Template.new(contents, File.expand_path(p), handler,
          :virtual_path => path, :format => format)
      end
    end
  end
end
