require "google_drive"

class MyDrive

  def initialize
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    @session = GoogleDrive::Session.from_config("config.json")
  end


  def get_files
    # Gets list of remote files.
    @session.files.each do |file|
      p file.title
    end
  end

  def get_all_data
    worksheet_id = "1-OUPuQOSle9Zs-2pYmwojxTM3gImtCTYO2YZxR8wDCo"
    ws = @session.spreadsheet_by_key("#{worksheet_id}").worksheets[0]

    data = format_data(ws)
    data
  end

  def format_data(ws)
    hsh = {}
    # setup columns
    (1..ws.num_cols).each do |col|
      hsh.merge!({ws[1,col] => []})
    end

    (1..ws.num_rows).each do |row|
      next if row == 1 # skip top row
      (1..ws.num_cols).each do |col|
        # add data to correct column
        hsh[ws[1,col]] << ws[row,col]
      end
    end
    hsh

  end
end

