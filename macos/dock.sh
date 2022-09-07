#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --add '' --type small-spacer --section apps --after Calendar
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Google Meet.app"
dockutil --add '' --type small-spacer --section apps --after "Google Meet"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --add '' --type small-spacer --section apps --after "Google Chrome"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/Applications/Evernote.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --add '' --type small-spacer --section apps --after Notes
dockutil --no-restart --add "/Applications/VSCodium.app"
dockutil --no-restart --add "/Applications/Sourcetree.app"
dockutil --no-restart --add "/Applications/Sequel Ace.app"
dockutil --no-restart --add "/Applications/Docker.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/Applications/Postman.app"
dockutil --add '' --type small-spacer --section apps --after Postman
dockutil --no-restart --add "/System/Applications/App Store.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"
dockutil --add '' --type small-spacer --section apps --after "System Preferences"
dockutil --no-restart --add "/Applications/Toggl Track.app"
dockutil --add '' --type small-spacer --section apps --after "Toggl Track"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Google Photos.app"

killall Dock
