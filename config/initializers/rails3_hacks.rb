module ActiveSupport
  module Cache
    class FileStore < Store
    
      private
      
        # Translate a file path into a key.
        def file_path_key(path)
          fname = path[cache_path.size, path.size].split(File::SEPARATOR, 4).last
          fname.gsub(UNESCAPE_FILENAME_CHARS){|match| [match.delete('%')].pack('H*') }
        end
    end
  end
end
