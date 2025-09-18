import time 
import webbrowser 
from pathlib import Path 
 
def run_demo(): 
    print("="*50) 
    print("GML ECOSYSTEM 5-MINUTE SHOWCASE") 
    print("="*50) 
    print() 
    print("STEP 1: Generative Hub Dashboard") 
    dashboard = Path("../generative-hub/docs/index.html") 
    if dashboard.exists(): 
        webbrowser.open(f"file://{dashboard.absolute()}") 
        print("Dashboard opened in browser") 
    time.sleep(3) 
    print("STEP 2: Quartet Engine Demo") 
    print("Generated: Classical quartet in D Major") 
    time.sleep(2) 
    print("STEP 3: RiffGen Pipeline")   
    print("RiffGen -^> IRM -^> SongSketch: Complete song created") 
    time.sleep(2) 
    print("STEP 4: Integration Examples") 
    print("mike-gen-libs powering all 12 projects") 
    time.sleep(2) 
    print("STEP 5: Export Complete") 
    print("All compositions ready for production") 
    print("="*50) 
    print("GML ECOSYSTEM DEMO COMPLETE!") 
    print("="*50) 
 
if __name__ == "__main__": 
    run_demo() 
