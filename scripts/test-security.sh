#!/bin/bash

# Basic validation script for security configurations
echo "🧪 Testing Security Configurations"
echo "=================================="
echo ""

# Test 1: YAML Syntax validation
echo "1. 📋 Validating _config.yml syntax..."
if ruby -ryaml -e "YAML.load_file('_config.yml')" 2>/dev/null; then
    echo "   ✅ _config.yml syntax is valid"
else
    echo "   ❌ _config.yml has syntax errors"
fi
echo ""

# Test 2: Markdown frontmatter validation  
echo "2. 📄 Validating index.md frontmatter..."
if head -10 index.md | grep -q "^---$"; then
    echo "   ✅ index.md has valid frontmatter"
else
    echo "   ❌ index.md frontmatter may be invalid"
fi
echo ""

# Test 3: Security workflow validation
echo "3. 🔧 Validating security workflow..."
if [ -f ".github/workflows/security-audit.yml" ]; then
    if grep -q "bundle-audit" .github/workflows/security-audit.yml; then
        echo "   ✅ Security audit workflow includes dependency checking"
    else
        echo "   ⚠️ Security audit workflow missing dependency checks"
    fi
else
    echo "   ❌ Security audit workflow not found"
fi
echo ""

# Test 4: Check for HTTPS enforcement
echo "4. 🔒 Checking HTTPS configurations..."
if grep -q "https://" index.md && grep -q "https://" _config.yml; then
    https_count=$(grep -c "https://" index.md _config.yml | head -2 | paste -sd+ | bc)
    echo "   ✅ HTTPS links found ($https_count locations)"
elif grep -q "https://" index.md || grep -q "https://" _config.yml; then
    echo "   ✅ HTTPS links found (some locations)"
else
    echo "   ⚠️ No HTTPS links found"
fi
echo ""

# Test 5: Validate .gitignore effectiveness
echo "5. 🙈 Testing .gitignore patterns..."
echo "test.key" > test.key
echo "secret.env" > secret.env
if git check-ignore test.key secret.env >/dev/null 2>&1; then
    echo "   ✅ .gitignore properly excludes sensitive files"
    rm -f test.key secret.env
else
    echo "   ❌ .gitignore may not properly exclude sensitive files"
    rm -f test.key secret.env
fi
echo ""

echo "✅ Security configuration validation complete!"
echo "📝 Run ./scripts/security-audit.sh for full security audit"