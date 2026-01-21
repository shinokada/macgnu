#!/usr/bin/env bash

# MacGNU Test Suite
# Run tests with: bash tests/run_tests.sh

# Don't use errexit or pipefail for tests - we want to capture errors
set -u

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0

# Test directory
TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$TEST_DIR")"

# Source the macgnu script in a subshell to avoid executing it
# We'll just test the executable directly instead
# source "$PROJECT_ROOT/macgnu"

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
    echo "  Output was: ${haystack:0:200}..."
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
  if [[ $TESTS_SKIPPED -gt 0 ]]; then
    echo -e "Skipped: ${YELLOW}$TESTS_SKIPPED${NC}"
  fi
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

test_script_exists() {
  test_start "Script file exists and is executable"

  if [[ -f "$PROJECT_ROOT/macgnu" ]]; then
    pass "macgnu script exists"
  else
    fail "macgnu script doesn't exist"
  fi

  if [[ -x "$PROJECT_ROOT/macgnu" ]]; then
    pass "macgnu script is executable"
  else
    fail "macgnu script is not executable"
  fi
}

test_help_output() {
  test_start "Help command output"

  local output
  output=$("$PROJECT_ROOT/macgnu" -h 2>&1) || true

  assert_contains "$output" "Description: Macgnu transforms" "- has description"
  assert_contains "$output" "install" "- install command listed"
  assert_contains "$output" "uninstall" "- uninstall command listed"
  assert_contains "$output" "status" "- status command listed"
  assert_contains "$output" "--dry-run" "- dry-run flag listed"
  assert_contains "$output" "--force" "- force flag listed"
}

test_version_output() {
  test_start "Version command output"

  local version
  version=$("$PROJECT_ROOT/macgnu" -v 2>&1) || true

  # Check version format (should be semantic versioning)
  if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    pass "version format is valid: $version"
  else
    fail "version format is invalid: $version"
  fi
}

test_help_shows_packages() {
  test_start "Help displays package information"

  local output
  output=$("$PROJECT_ROOT/macgnu" -h 2>&1) || true

  # Check for a few known packages
  assert_contains "$output" "tree" "- tree package listed"
  assert_contains "$output" "grep" "- grep package listed"
  assert_contains "$output" "bash" "- bash package listed"
}

# ========== INTEGRATION TESTS ==========

test_help_command_no_args() {
  test_start "Help output when no arguments provided"

  local output
  output=$("$PROJECT_ROOT/macgnu" 2>&1) || true

  assert_contains "$output" "Description: Macgnu transforms"
  assert_contains "$output" "Usage and options:"
}

test_invalid_command() {
  test_start "Invalid command handling"

  local output
  output=$("$PROJECT_ROOT/macgnu" invalid_command 2>&1) || true

  assert_contains "$output" "Description: Macgnu transforms"
}

test_dry_run_install() {
  test_start "Dry-run install mode"

  local output
  output=$("$PROJECT_ROOT/macgnu" install --dry-run 2>&1) || true

  assert_contains "$output" "DRY RUN MODE" "- shows dry run mode"
  assert_contains "$output" "would be installed" "- shows what would be installed"
}

test_dry_run_uninstall() {
  test_start "Dry-run uninstall mode"

  local output
  output=$("$PROJECT_ROOT/macgnu" uninstall --dry-run 2>&1) || true

  assert_contains "$output" "DRY RUN MODE" "- shows dry run mode"
}

test_status_command() {
  test_start "Status command"

  # This assumes brew is installed
  if command -v brew >/dev/null 2>&1; then
    local output
    output=$("$PROJECT_ROOT/macgnu" status 2>&1) || true

    assert_contains "$output" "MacGNU Installation Status" "- has status header"
    # Check for either installed packages or not installed message
    if [[ "$output" == *"Installed:"* ]] || [[ "$output" == *"✓"* ]] || [[ "$output" == *"✗"* ]]; then
      pass "shows package status information"
    else
      fail "doesn't show package status information"
    fi
  else
    echo -e "${YELLOW}⊘${NC} Skipping - brew not installed"
    ((TESTS_SKIPPED++))
  fi
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
    local content
    content=$(cat "$PROJECT_ROOT/.macgnu.conf.example")

    assert_contains "$content" "MACGNU_SKIP_PACKAGES" "- has MACGNU_SKIP_PACKAGES"
  else
    fail "config file example doesn't exist"
  fi
}

test_readme_exists() {
  test_start "README file exists"

  if [[ -f "$PROJECT_ROOT/README.md" ]]; then
    pass "README.md exists"
  else
    fail "README.md doesn't exist"
  fi
}

test_license_exists() {
  test_start "LICENSE file exists"

  if [[ -f "$PROJECT_ROOT/LICENSE" ]]; then
    pass "LICENSE exists"
  else
    echo -e "${YELLOW}⊘${NC} LICENSE doesn't exist (optional)"
    ((TESTS_SKIPPED++))
  fi
}

# ========== RUN ALL TESTS ==========

main() {
  echo "================================"
  echo "MacGNU Test Suite"
  echo "================================"
  echo "Project: $PROJECT_ROOT"

  # Basic Tests
  test_script_exists

  # Command Output Tests
  test_help_output
  test_version_output
  test_help_shows_packages

  # Integration Tests
  test_help_command_no_args
  test_invalid_command
  test_dry_run_install
  test_dry_run_uninstall
  test_config_file_example_exists
  test_config_file_example_content

  # Documentation Tests
  test_readme_exists
  test_license_exists

  # Tests that may skip if brew is not installed
  test_status_command

  # Print summary
  test_summary
}

main "$@"
