# Obsidian Daily Note Cleanup
**Ruby version preferred**
_Python script is older and not updated_

![Code Sample](./daily_note_cleanup.png)

This is a simple script that completes the following tasks:
#### Move 'empty' files to the trash

'Empty' is determined by comparing each file to the Template file used by Obsidian to create a new note each day.

My template generates a title line based on the date, since this will always be different, the script just ignores this first line.

_Ruby Script_ The newer .rb script dynamically ignores the date line regardless of location.

The remaining lines are checked for any differences, if there are none the file will be moved to the Trash.

#### Move files created 7 or more days ago to an Archive folder

After removing 'empty' files, the script checks if each remaining file was created 7 or more days ago.

If the file is 7+ days old, it is moved to a folder in Archive based on year. 


### Configuration

Variables that should be updated when using on a different system:
#### Ruby
`OBSIDIAN_PATH` - point to abs path of Obsidian vault

`TRASH_PATH` - update user folder name

`ARCHIVE_TIME` - default set to 7 days, can be adjusted to any time period
#### Python

`notes_path` - point to abs path of notes

`trash_path` - update user folder name

`archive_path` - point to abs path of archive directory

`template` - update rel path of .md template file that Obsidian is using to generate new Daily Notes

Optional:

`archive_time` - default set to 7 days, can be adjusted to any time period

### Automation
Example cron schedule:
`0 9 * * 5 /Users/usr/.rbenv/shims/ruby /Users/usr/repos/Daily-Note-Cleanup/daily_note_cleanup.rb >> /Users/usr/repos/Daily-Note-Cleanup/cron_log.log 2>&1`

- This schedule will run at 9:00AM (0 9) every Friday (5)
- Path to ruby assumes rbenv, update depending on Ruby location
- Any output/errors are logged to `cron_log.log`
