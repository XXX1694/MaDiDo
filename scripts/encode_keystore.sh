#!/bin/bash

# Script to encode keystore to base64 for GitHub Secrets

echo "🔐 Encoding keystore to base64..."
echo ""

KEYSTORE_PATH="android/app/upload-keystore.jks"

if [ ! -f "$KEYSTORE_PATH" ]; then
    echo "❌ Error: Keystore file not found at $KEYSTORE_PATH"
    exit 1
fi

echo "📦 Keystore found!"
echo ""
echo "🔄 Encoding..."
echo ""

# Encode to base64
BASE64_OUTPUT=$(base64 < "$KEYSTORE_PATH")

# Save to temporary file
echo "$BASE64_OUTPUT" > keystore_base64.txt

echo "✅ Done!"
echo ""
echo "📋 The base64 encoded keystore has been saved to: keystore_base64.txt"
echo ""
echo "📝 Next steps:"
echo "1. Copy the contents of keystore_base64.txt"
echo "2. Go to GitHub → Settings → Secrets → New repository secret"
echo "3. Name: KEYSTORE_BASE64"
echo "4. Value: Paste the copied content"
echo "5. Delete keystore_base64.txt after copying"
echo ""
echo "⚠️  IMPORTANT: Do not commit keystore_base64.txt to git!"

