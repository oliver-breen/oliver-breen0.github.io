#!/bin/bash

# Security Audit Script for Portfolio Site
# This script performs basic security checks for a Jekyll-based GitHub Pages site

echo "🔍 Security Audit for Oliver Breen's Portfolio"
echo "============================================="
echo ""

# Check 1: Sensitive Files
echo "1. 🔒 Checking for sensitive files..."
sensitive_files=$(find . -name "*.key" -o -name "*.pem" -o -name "*.p12" -o -name "*.pfx" -o -name "secret*" -o -name ".env*" | grep -v ".github" | head -5)
if [ -z "$sensitive_files" ]; then
    echo "   ✅ No sensitive files found"
else
    echo "   ❌ Sensitive files detected:"
    echo "$sensitive_files"
fi
echo ""

# Check 2: Configuration Security
echo "2. ⚙️ Checking Jekyll configuration security..."
if grep -q "strict_front_matter: true" _config.yml; then
    echo "   ✅ Strict front matter enabled"
else
    echo "   ⚠️ Consider enabling strict front matter"
fi

if grep -q "enforce_ssl: true" _config.yml; then
    echo "   ✅ SSL enforcement configured"
else
    echo "   ⚠️ SSL enforcement not configured"
fi
echo ""

# Check 3: GitHub Actions Security
echo "3. 🔧 Checking GitHub Actions security..."
if [ -f ".github/workflows/security-audit.yml" ]; then
    echo "   ✅ Security audit workflow found"
else
    echo "   ❌ No security audit workflow"
fi

if grep -q "permissions:" .github/workflows/jekyll-gh-pages.yml; then
    echo "   ✅ Workflow permissions defined"
else
    echo "   ⚠️ Workflow permissions not explicitly defined"
fi
echo ""

# Check 4: Content Security
echo "4. 📄 Checking content security..."
if grep -q "https://" index.md; then
    echo "   ✅ HTTPS links found in content"
else
    echo "   ⚠️ No HTTPS links found - check external links"
fi

# Check for potential PII exposure
pii_check=$(grep -i -E "(password|secret|key|token|ssn|social|credit)" index.md | head -3)
if [ -z "$pii_check" ]; then
    echo "   ✅ No obvious PII exposure detected"
else
    echo "   ⚠️ Potential sensitive information found - please review"
fi
echo ""

# Check 5: Dependencies
echo "5. 📦 Checking dependencies..."
if [ -f "Gemfile" ]; then
    echo "   ✅ Gemfile found"
    if grep -q "bundler-audit" Gemfile; then
        echo "   ✅ Security auditing gem included"
    else
        echo "   ⚠️ Consider adding bundler-audit for dependency scanning"
    fi
else
    echo "   ⚠️ No Gemfile found"
fi
echo ""

# Check 6: Security Documentation
echo "6. 📋 Checking security documentation..."
if [ -f "SECURITY.md" ]; then
    echo "   ✅ Security policy found"
else
    echo "   ❌ No security policy found"
fi

if [ -f ".gitignore" ]; then
    echo "   ✅ .gitignore file exists"
    if grep -q "*.key" .gitignore; then
        echo "   ✅ Sensitive file patterns in .gitignore"
    else
        echo "   ⚠️ Consider adding sensitive file patterns to .gitignore"
    fi
else
    echo "   ❌ No .gitignore file found"
fi
echo ""

echo "🎯 Security Audit Summary"
echo "========================"
echo "✅ = Good security practice"
echo "⚠️ = Recommendation for improvement"
echo "❌ = Security issue requiring attention"
echo ""
echo "📝 For detailed security information, see SECURITY.md"