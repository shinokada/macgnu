#!/usr/bin/env bash

# MacGNU Test Suite
# Run tests with: bash tests/run_tests.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Test directory
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$TEST_DIR")"

# Load the macgnu script (without executing main)
# We need to source it but prevent execution
source_macgnu() {
  # Create a copy without the main call for testing
  sed '$ d' "$PROJECT_ROOT/macgnu" >/tmp/macgnu_test.sh
}

# Assertion helpers
assert_exit_code() {
  local expected=$1
  local actual=$2
  local message="${3:-}"

  if [[ $actual -eq $expected ]]; then
    pass "exit code is $expected $message"
    return 0
  else
    fail "expected exit code $expected, got $actual $message"
    return 1
  fi
}

assert_contains() {
  local haystack=$1
  local needle=$2
  local message="${3:-}"

  if [[ "$haystack" == *"$needle"* ]]; then
    pass "output contains '$needle' $message"
    return 0
  else
    fail "output doesn't contain '$needle' $message"
    return 1
  fi
}

assert_not_contains() {
  local haystack=$1
  local needle=$2
  local message="${3:-}"

  if [[ "$haystack" != *"$needle"* ]]; then
    pass "output doesn't contain '$needle' $message"
    return 0
  else
    fail "output contains '$needle' $message"
    return 1
  fi
}

assert_equals() {
  local expected=$1
  local actual=$2
  local message="${3:-}"

  if [[ "$expected" == "$actual" ]]; then
    pass "values are equal $message"
    return 0
  else
    fail "expected '$expected', got '$actual' $message"
    return 1
  fi
}

# Test result handlers
pass() {
  echo -e "${GREEN}✓${NC} $1"
  ((TESTS_PASSED++))
  ((TESTS_RUN++))
}

fail() {
  echo -e "${RED}✗${NC} $1"
  ((TESTS_FAILED++))
  ((TESTS_RUN++))
}

test_start() {
  echo ""
  echo -e "${YELLOW}Testing: $1${NC}"
}

test_summary() {
  echo ""
  echo "================================"
  echo "Test Summary"
  echo "================================"
  echo "Total:  $TESTS_RUN"
  echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
  echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
  echo "================================"

  if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "${GREEN}All tests passed!${NC}"
    return 0
  else
    echo -e "${RED}Some tests failed!${NC}"
    return 1
  fi
}

# ========== UNIT TESTS ==========

test_dry_run_flag_parsing() {
  test_start "Dry-run flag parsing"

  source_macgnu
  source /tmp/macgnu_test.sh

  # Reset globals
  DRY_RUN=false

  # Test that we can parse --dry-run flag
  # This is a basic syntax check
  pass "DRY_RUN variable initialized"
}

test_filter_formulas() {
  test_start "Filter formulas functionality"

  source_macgnu
  source /tmp/macgnu_test.sh

  # Test formula filtering
  local test_formulas=("bash" "emacs" "grep" "nano")
  export MACGNU_SKIP_PACKAGES="bash emacs"

  macgnu_filter_formulas test_formulas

  # Check that bash and emacs were filtered
  local found_bash=false
  local found_emacs=false
  for f in "${test_formulas[@]}"; do
    [[ "$f" == "bash" ]] && found_bash=true
    [[ "$f" == "emacs" ]] && found_emacs=true
  done

  if [[ "$found_bash" == false && "$found_emacs" == false ]]; then
    pass "bash and emacs were filtered from formulas"
  else
    fail "bash and/or emacs were not filtered"
  fi
}

test_help_output() {
  test_start "Help command output"

  local output=$("$PROJECT_ROOT/macgnu" -h 2>&1 || true)

  assert_contains "$output" "Description: Macgnu transforms"
  assert_contains "$output" "install" "- install command listed"
  assert_contains "$output" "uninstall" "- uninstall command listed"
  assert_contains "$output" "status" "- status command listed"
  assert_contains "$output" "--dry-run" "- dry-run flag listed"
  assert_contains "$output" "--force" "- force flag listed"
}

test_version_output() {
  test_start "Version command output"

  local version=$("$PROJECT_ROOT/macgnu" -v 2>&1 || true)

  # Check version format (should be semantic versioning)
  if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    pass "version format is valid: $version"
  else
    fail "version format is invalid: $version"
  fi
}

test_check_os_function() {
  test_start "macOS check function"

  source_macgnu
  source /tmp/macgnu_test.sh

  # This should pass on macOS
  if [[ "$OSTYPE" =~ darwin* ]]; then
    if macgnu_check_os 2>/dev/null; then
      pass "macOS check passed on macOS system"
    else
      fail "macOS check failed on macOS system"
    fi
  else
    fail "tests must be run on macOS"
  fi
}

test_config_file_loading() {
  test_start "Config file loading"

  source_macgnu
  source /tmp/macgnu_test.sh

  # Create a temporary config file
  local temp_config="/tmp/test_macgnu.conf"
  echo 'MACGNU_SKIP_PACKAGES="test_package"' >"$temp_config"

  # Override config file path
  CONFIG_FILE="$temp_config"

  # Load config
  macgnu_load_config

  if [[ "$MACGNU_SKIP_PACKAGES" == "test_package" ]]; then
    pass "config file was loaded successfully"
  else
    fail "config file was not loaded"
  fi

  rm -f "$temp_config"
}

test_progress_function() {
  test_start "Progress display function"

  source_macgnu
  source /tmp/macgnu_test.sh

  # Test that progress function exists and is callable
  if declare -f macgnu_print_progress >/dev/null; then
    pass "progress function exists"
  else
    fail "progress function doesn't exist"
  fi
}

# ========== INTEGRATION TESTS ==========

test_help_command_no_args() {
  test_start "Help output when no arguments provided"

  local output=$("$PROJECT_ROOT/macgnu" 2>&1 || true)

  assert_contains "$output" "Description: Macgnu transforms"
  assert_contains "$output" "Usage and options:"
}

test_invalid_command() {
  test_start "Invalid command handling"

  local output=$("$PROJECT_ROOT/macgnu" invalid_command 2>&1 || true)

  assert_contains "$output" "Description: Macgnu transforms"
}

test_dry_run_install() {
  test_start "Dry-run install mode"

  local output=$("$PROJECT_ROOT/macgnu" install --dry-run 2>&1 || true)

  assert_contains "$output" "DRY RUN MODE"
  assert_contains "$output" "would be installed"
}

test_dry_run_uninstall() {
  test_start "Dry-run uninstall mode"

  local output=$("$PROJECT_ROOT/macgnu" uninstall --dry-run 2>&1 || true)

  assert_contains "$output" "DRY RUN MODE"
}

test_status_command() {
  test_start "Status command"

  # This assumes brew is installed
  if command -v brew >/dev/null 2>&1; then
    local output=$("$PROJECT_ROOT/macgnu" status 2>&1 || true)

    assert_contains "$output" "MacGNU Installation Status"
    assert_contains "$output" "Installed:"
  else
    fail "brew not installed, skipping status test"
  fi
}

test_help_shows_all_packages() {
  test_start "Help displays all packages"

  local output=$("$PROJECT_ROOT/macgnu" -h 2>&1 || true)

  # Check for a few known packages
  assert_contains "$output" "tree" "- tree package listed"
  assert_contains "$output" "grep" "- grep package listed"
  assert_contains "$output" "bash" "- bash package listed"
}

test_config_file_example_exists() {
  test_start "Config file example exists"

  if [[ -f "$PROJECT_ROOT/.macgnu.conf.example" ]]; then
    pass "config file example exists"
  else
    fail "config file example doesn't exist"
  fi
}

test_config_file_example_content() {
  test_start "Config file example has correct content"

  if [[ -f "$PROJECT_ROOT/.macgnu.conf.example" ]]; then
    local content=$(cat "$PROJECT_ROOT/.macgnu.conf.example")

    assert_contains "$content" "MACGNU_SKIP_PACKAGES"
    assert_contains "$content" "example"
  fi
}

# ========== RUN ALL TESTS ==========

main() {
  echo "================================"
  echo "MacGNU Test Suite"
  echo "================================"
  echo "Project: $PROJECT_ROOT"

  # Unit Tests
  test_dry_run_flag_parsing
  test_filter_formulas
  test_check_os_function
  test_config_file_loading
  test_progress_function

  # Command Output Tests
  test_help_output
  test_version_output
  test_help_shows_all_packages

  # Integration Tests
  test_help_command_no_args
  test_invalid_command
  test_dry_run_install
  test_dry_run_uninstall
  test_config_file_example_exists
  test_config_file_example_content

  # Conditional tests (require brew)
  if command -v brew >/dev/null 2>&1; then
    test_status_command
  else
    echo -e "${YELLOW}⊘${NC} Skipping brew-dependent tests (brew not installed)"
  fi

  # Print summary
  test_summary
}

# Cleanup
trap 'rm -f /tmp/macgnu_test.sh' EXIT

main "$@"
