# Makefile

# Define the path to the script
SCRIPT_PATH=setup/symlink-env.sh

# Define the target
.PHONY: symlink-env

# Target to run the script
symlink-env:
	@echo "Running symlink-env.sh script..."
	@$(SHELL) $(SCRIPT_PATH)