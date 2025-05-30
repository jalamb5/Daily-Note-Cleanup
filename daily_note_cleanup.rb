# frozen_string_literal: true

# daily_note_cleanup.py rewritten in Ruby.
# Allows flexibility of template lines, ie. date line dynamically extracted rather than removing line 1
# Moves notes which match template array exactly to trash
# Moves notes with birthtime of greater than 7 days to Archive folder

require 'fileutils'

OBSIDIAN_PATH = '/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/'
TEMPLATE_PATH = "#{OBSIDIAN_PATH}Templates/DailyNoteTemplate.md"
ARCHIVE_PATH = "#{OBSIDIAN_PATH}Daily Notes/Archive"
TRASH_PATH = '/Users/justinlamb/.Trash/'
IGNORE_LINE = ['{{date:dddd, MMMM Do YYYY}}', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',
               'Sunday'].freeze
ARCHIVE_TIME = (24 * 3600) * 7
trash_count = 0
archive_count = 0

template = []
File.foreach(TEMPLATE_PATH) { |line| template << line unless line.match? Regexp.union(IGNORE_LINE) }

notes = Dir["#{OBSIDIAN_PATH}Daily Notes/*.md"].select

puts "📝 Checking Daily Notes"

notes.each do |file|
  note = []
  year = File.basename(file)[0..3]
  dir = "#{ARCHIVE_PATH}/#{year}"
  Dir.mkdir(dir) unless Dir.exist?(dir)
  File.foreach(file) { |line| note << line unless line.match? Regexp.union(IGNORE_LINE) }
  FileUtils.mv(file, TRASH_PATH) && trash_count += 1 if note == template
  FileUtils.mv(file, dir) && archive_count += 1 if File.stat(file).birthtime < Time.now - ARCHIVE_TIME
end

puts "✅ #{archive_count} note(s) archived. #{trash_count} note(s) deleted."