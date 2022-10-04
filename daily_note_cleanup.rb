# frozen_string_literal: true

require 'fileutils'

TEMPLATE_PATH = '/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Templates/DailyNoteTemplate.md'
ARCHIVE_PATH = '/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Daily Notes/Archive'
TRASH_PATH = '/Users/justinlamb/.Trash/'
IGNORE_LINE = ['{{date:dddd, MMMM Do YYYY}}', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'].freeze

template = []
File.foreach(TEMPLATE_PATH) { |line| template << line unless line.match? Regexp.union(IGNORE_LINE) }

notes = Dir['/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Daily Notes/*.md'].select

notes.each do |file|
  note = []
  File.foreach(file) { |line| note << line unless line.match? Regexp.union(IGNORE_LINE) }
  FileUtils.mv(file, TRASH_PATH) if note == template
  FileUtils.mv(file, ARCHIVE_PATH) if File.stat(file).birthtime < Time.now - (24 * 3600) * 7
end
