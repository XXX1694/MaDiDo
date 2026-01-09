#!/bin/bash

# Script to set up git hooks for Flutter project

echo "🔧 Setting up Git hooks..."
echo ""

# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

echo "🔍 Running pre-commit checks..."
echo ""

# Format code
echo "✨ Formatting code..."
dart format . > /dev/null 2>&1

# Add formatted files
git add -u

# Generate code if needed
if [ -f "pubspec.yaml" ] && grep -q "build_runner" "pubspec.yaml"; then
    echo "🔨 Checking generated files..."
    # Only generate if .g.dart files are staged
    if git diff --cached --name-only | grep -q ".g.dart"; then
        echo "Generating code..."
        flutter pub run build_runner build --delete-conflicting-outputs > /dev/null 2>&1
        git add -u
    fi
fi

# Analyze
echo "🔍 Analyzing code..."
flutter analyze --no-pub > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Flutter analyze found issues. Running detailed analysis..."
    flutter analyze --no-pub
    echo ""
    echo "Please fix the issues above before committing."
    exit 1
fi

echo ""
echo "✅ All pre-commit checks passed!"
echo ""

exit 0
EOF

# Make it executable
chmod +x .git/hooks/pre-commit

echo "✅ Git hooks installed successfully!"
echo ""
echo "📝 The pre-commit hook will automatically:"
echo "   1. Format your code"
echo "   2. Generate code if needed"
echo "   3. Run Flutter analyze"
echo ""
echo "🎯 To skip hooks (not recommended):"
echo "   git commit --no-verify"
echo ""

