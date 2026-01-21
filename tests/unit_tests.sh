#!/usr/bin/env bash

# MacGNU Unit Tests - Flag Parsing
# Tests for argument and flag parsing logic

# Don't use pipefail or errexit for tests - we want to continue on failures
set -u

TEST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

TESTS=0
PASSED=0

test() {
  local name="$1"
  local expected="$2"
  local actual="$3"

  ((TESTS++))

  if [[ "$expected" == "$actual" ]]; then
    echo -e "${GREEN}✓${NC} $name"
    ((PASSED++))
  else
    echo -e "${RED}✗${NC} $name"
    echo "  Expected: $expected"
    echo "  Actual:   $actual"
  fi
}

# Test flag parsing
echo "Testing flag parsing..."

# Simulate flag parsing logic
test_flags() {
  local DRY_RUN=false
  local FORCE_INSTALL=false

  for arg in "$@"; do
    case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    --force)
      FORCE_INSTALL=true
      ;;
    esac
  done

  echo "$DRY_RUN:$FORCE_INSTALL"
}

test "No flags" "false:false" "$(test_flags)"
test "Dry-run flag" "true:false" "$(test_flags --dry-run)"
test "Force flag" "false:true" "$(test_flags --force)"
test "Both flags" "true:true" "$(test_flags --dry-run --force)"

# Test command parsing
echo ""
echo "Testing command parsing..."

test_command() {
  local cmd=""

  for arg in "$@"; do
    case "$arg" in
    install | uninstall | status | info)
      cmd="$arg"
      break
      ;;
    esac
  done

  echo "$cmd"
}

test "Install command" "install" "$(test_command install)"
test "Uninstall command" "uninstall" "$(test_command uninstall)"
test "Status command" "status" "$(test_command status)"
test "Info command" "info" "$(test_command info)"
test "No command" "" "$(test_command)"

# Summary
echo ""
echo "================================"
echo "Unit Test Summary"
echo "================================"
echo "Total:  $TESTS"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo "Failed: $((TESTS - PASSED))"

if [[ $((TESTS - PASSED)) -eq 0 ]]; then
  echo -e "${GREEN}All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}Some tests failed!${NC}"
  exit 1
fi
