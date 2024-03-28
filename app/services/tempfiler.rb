# frozen_string_literal: true

class Tempfiler
  def self.from_zip(zip_file, attachment)
    return unless attachment

    Tempfile.create('attachment', binmode: true) do |tf|
      tf.write(zip_file.glob(attachment).first.get_input_stream.read)
      tf.rewind
      yield(tf)
    end
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    Rails.logger.error("Attachment: #{attachment}")
    raise(e)
  end
end
