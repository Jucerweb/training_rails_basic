module Picturable
  extend ActiveSupport::Concern
  include do
    after_save :save_image
  end

  PATH_ARCHIVES = File.join Rails.root, "public", "archives"

  def archive=(archive)
    unless archive.blank?
      @archive = archive
      if self.respond_to?(:name)
        self.name = archive.original_filename
      end
      self.extension = archive.original_filename.split(".").last.downcase
    end
  end

  def path_archive
    File.join PATH_ARCHIVES, "#{self.id}.#{self.extension}"
  end

  def have_archive?
    File.exists? path_archive
  end

  private
  def save_image
    if @archive
      FileUtils.mkdir_p PATH_ARCHIVES
      File.open(path_archive,"wb") do|f|
        f.write(@archive.read)
      end
      @archive = nil
    end
  end
end