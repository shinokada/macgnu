#!/usr/bin/env bash

# Quick test to verify the while-read approach works

echo "Testing Bash 3.2 compatible array population..."

# Simulate the filter function
test_filter() {
    printf '%s\n' "bash" "grep" "sed"
}

# Old way (Bash 4+) - commented out
# local -a result
# mapfile -t result < <(test_filter)

# New way (Bash 3.2+)
result=()
while IFS= read -r item; do
    result+=("$item")
done < <(test_filter)

echo "Array contents:"
for item in "${result[@]}"; do
    echo "  - $item"
done

echo ""
echo "Array length: ${#result[@]}"
echo ""

if [[ ${#result[@]} -eq 3 ]]; then
    echo "✓ Test passed - array populated correctly"
    exit 0
else
    echo "✗ Test failed - expected 3 items, got ${#result[@]}"
    exit 1
fi
