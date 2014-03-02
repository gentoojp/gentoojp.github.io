module Jekyll
  class XSLTConverter < Converter
    XML_STYLESHEET = '<?xml-stylesheet'
    GUIDE_DTD = %Q[guide SYSTEM "/dtd/guide.dtd"]
    NEWS_DTD = %Q[news SYSTEM "/dtd/guide.dtd"]
    safe true

    def setup
      unless system("xsltproc --version > /dev/null")
        raise "xsltproc must be installed"
      end
      ENV['SGML_CATALOG_FILES'] = File.join(File.dirname(__FILE__), '..', 'catalog.xml')
    end

    def matches(ext)
      ext =~ /xml/i
    end

    def output_ext(ext)
      ".html"
    end

    def insert_default_stylesheet_if_needed(content)
      if !content.include?(XML_STYLESHEET)
        content.sub(/<\?xml version=["']1.0["'](?: encoding=["']UTF-8["'])?\?>/i) { |x|
          x + %Q{<?xml-stylesheet href="/xsl/guide.xsl" type="text/xsl"?>}
        }
      else
        content
      end
    end

    def validate?(content)
      content.include?(GUIDE_DTD)
    end

    def validate(content)
      a = IO.popen("xmllint --valid --noout --catalogs - 2>&1", "r+") { |io|
        io.print insert_default_stylesheet_if_needed(content)
        io.close_write
        io.read
      }
      if $?.to_i != 0
        STDERR.puts content
        raise a
      end
    end

    def convert?(content)
      [XML_STYLESHEET, GUIDE_DTD, NEWS_DTD].any? { |m|
        content.include?(m)
      }
    end

    def convert(content)
      setup
      if convert?(content)
        validate(content) if validate?(content)

        a = IO.popen("xsltproc --catalogs - 2>&1", "r+") { |io|
          io.print insert_default_stylesheet_if_needed(content)
          io.close_write
          io.read
        }
        if $?.to_i != 0
          STDERR.puts content
          raise a
        end
        a
      else
        content
      end
    end
  end
end
