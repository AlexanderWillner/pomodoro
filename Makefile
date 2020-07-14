LOGFILE=make.log

help: ## Print help for each target
	$(info Pomodoro.app Makefile)
	$(info =====================)
	$(info )
	$(info Log File: $(LOGFILE))
	$(info )
	$(info Available commands:)
	@grep '^[[:alnum:]_-]*:.* ##' $(MAKEFILE_LIST) \
	| sort | awk 'BEGIN {FS=":.* ## "}; {printf "%-25s %s\n", $$1, $$2};'
    
timer: info ## Build Timer.app
	@echo "Building Timer.app..."
	@xcodebuild -configuration Release -scheme Timer -project Timer.xcodeproj >> $(LOGFILE)
	@echo "Find the binary at: "
	@egrep "^Touch.*app$$" $(LOGFILE)

no-sig: info ## Remove default signature information
	@echo "Removing signature information..."
	@find . -name "project.pbxproj" -exec sed -i '' "s/.*CODE_SIGN_IDENTITY.*//g" {} \; 
	@find . -name "project.pbxproj" -exec sed -i '' "s/.*DEVELOPMENT_TEAM.*//g" {} \; 

info:
	@echo "Logging output to file '$(LOGFILE)'"
	@echo "" > $(LOGFILE)

clean: info ## Cleanup
	@echo "Cleaning up..."
	@xcodebuild -configuration Release -scheme Timer -project Timer.xcodeproj clean >> $(LOGFILE)

xcode: ## Open Xcode project 
	@open Timer.xcodeproj