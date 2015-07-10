# encoding: utf-8
module Mail

  # Field List class provides an enhanced array that keeps a list of 
  # email fields in order.  And allows you to insert new fields without
  # having to worry about the order they will appear in.
  class FieldList < Array

    include Enumerable

    def set_options(options)
      @options = options
      self
    end

    # Insert the field in sorted order.
    #
    # Heavily based on bisect.insort from Python, which is:
    #   Copyright (C) 2001-2013 Python Software Foundation.
    #   Licensed under <http://docs.python.org/license.html>
    #   From <http://hg.python.org/cpython/file/2.7/Lib/bisect.py>
    def <<( new_field )
      if defined?(@options) && @options && @options[:no_header_formatted]
        super
      else
        lo = 0
        hi = size

        while lo < hi
          mid = (lo + hi).div(2)
          if new_field < self[mid]
            hi = mid
          else
            lo = mid + 1
          end
        end

        insert(lo, new_field)
      end
    end
  end
end
