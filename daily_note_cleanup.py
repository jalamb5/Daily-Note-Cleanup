#!/usr/bin/env python

# This looks at all Daily Notes and compares their contents to the template file. If the files are exactly the same as the template, they are moved to the trash.
# After trashing empty Daily Notes, we check the creation dates and move any Daily Notes older than 7 days to the Archive folder.

import os
import time

notes_path = '/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Daily Notes'
trash_path = '/Users/justinlamb/.Trash/'
archive_path = '/Users/justinlamb/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian/Daily Notes/Archive'
files = os.listdir(notes_path)
template = open(os.path.join(notes_path, './Archive/DailyNoteTemplate.md'))

template_lines = template.readlines()[1:]

week = 604800
now = time.time()
cutoff = now - week 

for file in files:
    if os.path.isfile(os.path.join(notes_path, file)):
        if file != '.DS_Store':
            creation = os.path.getctime(os.path.join(notes_path, file)) # Find creation date.
            f = open(os.path.join(notes_path, file),'r')
            f_lines = f.readlines()[1:]
            if f_lines == template_lines: # Compare to template and trash empty notes.
                os.rename(os.path.join(notes_path, file), os.path.join(trash_path, file))
            elif creation < cutoff: # Archive files older than 7 days.
                os.rename(os.path.join(notes_path, file), os.path.join(archive_path, file))
            f.close()
