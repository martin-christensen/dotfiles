# Setup defaults
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool true
defaults write com.knollsoft.Rectangle gapSize -int 0
defaults write com.knollsoft.Rectangle hideMenubarIcon -bool false
defaults write com.knollsoft.Rectangle launchOnLogin -bool true
defaults write com.knollsoft.Rectangle subsequentExecutionMode -bool true
defaults write com.knollsoft.Rectangle unsnapRestore -bool true
defaults write com.knollsoft.Rectangle windowSnapping -bool true

# Setup key binding for almost maximize
defaults write com.knollsoft.Rectangle almostMaximize -dict-add KeyCode -int 45
defaults write com.knollsoft.Rectangle almostMaximize -dict-add modifierFlags -int 786432

# Setup key binding for maximize
defaults write com.knollsoft.Rectangle maximize -dict-add KeyCode -int 46
defaults write com.knollsoft.Rectangle maximize -dict-add modifierFlags -int 786432

# Setup key binding for topleft
defaults write com.knollsoft.Rectangle topLeft -dict-add KeyCode -int 83
defaults write com.knollsoft.Rectangle topLeft -dict-add modifierFlags -int 786432

# Setup key binding for topright
defaults write com.knollsoft.Rectangle topRight -dict-add KeyCode -int 84
defaults write com.knollsoft.Rectangle topRight -dict-add modifierFlags -int 786432

# Setup key binding for bottomleft
defaults write com.knollsoft.Rectangle bottomLeft -dict-add KeyCode -int 85
defaults write com.knollsoft.Rectangle bottomLeft -dict-add modifierFlags -int 786432

# Setup key binding for bottom right
defaults write com.knollsoft.Rectangle bottomRight -dict-add KeyCode -int 86
defaults write com.knollsoft.Rectangle bottomRight -dict-add modifierFlags -int 786432
