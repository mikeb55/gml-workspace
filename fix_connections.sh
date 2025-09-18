#!/bin/bash
echo "🔧 Connecting Template System to Generators..."

# The connector code
CONNECTOR='
<script>
// Connect Template System to Generator
window.addEventListener("DOMContentLoaded", () => {
    setTimeout(() => {
        if (window.templateSystem && window.templateSystem.currentTemplate) {
            // Hook into generate functions
            const oldGen = window.generate || window.generateRiff || window.generateQuartet;
            if (oldGen) {
                window.generate = window.generateRiff = window.generateQuartet = function() {
                    console.log("Using", window.templateSystem.currentTemplate.genre, "template");
                    // Apply template settings
                    const t = window.templateSystem.currentTemplate;
                    if (t.tempo && document.getElementById("tempo")) {
                        document.getElementById("tempo").value = t.tempo.default;
                    }
                    return oldGen.apply(this, arguments);
                };
            }
        }
    }, 1000);
});
</script>'

# Add connector to the problem apps
for app in gml-riffgen gml-quartet quintet-composer; do
    # Find the HTML file
    HTML=$(find "$app" -maxdepth 1 -name "*enhanced*.html" -o -name "*.html" | head -1)
    if [ ! -z "$HTML" ]; then
        echo "Fixing $app..."
        # Add connector before </body>
        if ! grep -q "Connect Template System to Generator" "$HTML"; then
            sed -i "s|</body>|$CONNECTOR\n</body>|" "$HTML"
            echo "✅ Fixed $HTML"
        fi
    fi
done

echo "🎉 Connections fixed! Try the apps again."
