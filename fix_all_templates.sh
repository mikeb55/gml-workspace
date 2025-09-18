#!/bin/bash

echo "🔍 FINDING & FIXING ALL HTML FILES"
echo "==================================="
echo ""

TEMPLATE_CODE='
<!-- GML Template System -->
<script src="https://raw.githubusercontent.com/mikeb55/-gml-enhancement-suite/main/templates/TemplateSystem.js"></script>
<script>
window.addEventListener("DOMContentLoaded", async () => {
    try {
        window.templateSystem = new TemplateSystem();
        await window.templateSystem.init();
        let c = document.getElementById("controls") || document.querySelector(".controls") || document.body;
        window.templateSystem.createDropdown(c.id || "controls", (g,t) => console.log("Template loaded:", g));
    } catch(e) { console.log("Template System load error:", e); }
});
</script>'

# Check each app directory
for app in gml-riffgen triadgen quartet-engine drum-engine gml-quartet generative-chamber-composer quintet-composer infinite-riff-machine string-fx-mapper; do
    echo "🔍 Checking $app..."
    
    if [ ! -d "$app" ]; then
        echo "  ⏭️ Directory not found"
        continue
    fi
    
    # Find ANY HTML file in the directory
    HTML_FILES=$(find "$app" -maxdepth 1 -name "*.html" 2>/dev/null | head -5)
    
    if [ -z "$HTML_FILES" ]; then
        echo "  ❌ No HTML files found"
        continue
    fi
    
    # Process each HTML file found
    for html_file in $HTML_FILES; do
        echo "  📄 Found: $(basename $html_file)"
        
        # Check if Template System already added
        if grep -q "Template System" "$html_file" 2>/dev/null; then
            echo "    ✓ Already has Template System"
        else
            # Add Template System before </body> or </html>
            if grep -q "</body>" "$html_file"; then
                # Create temp file with template added
                awk -v template="$TEMPLATE_CODE" '/<\/body>/{print template} 1' "$html_file" > "${html_file}.tmp"
                mv "${html_file}.tmp" "$html_file"
                echo "    ✅ Template System added!"
            elif grep -q "</html>" "$html_file"; then
                awk -v template="$TEMPLATE_CODE" '/<\/html>/{print template} 1' "$html_file" > "${html_file}.tmp"
                mv "${html_file}.tmp" "$html_file"
                echo "    ✅ Template System added!"
            else
                echo "$TEMPLATE_CODE" >> "$html_file"
                echo "    ✅ Template System appended!"
            fi
        fi
    done
    echo ""
done

echo "🎉 TEMPLATE SYSTEM INTEGRATION COMPLETE!"
echo ""
echo "📋 Quick Test Links:"
ls -d */ | while read dir; do
    HTML=$(find "$dir" -maxdepth 1 -name "*.html" 2>/dev/null | head -1)
    if [ ! -z "$HTML" ]; then
        echo "  • $dir → file://$(pwd)/$HTML"
    fi
done
