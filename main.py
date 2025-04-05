from fastapi import FastAPI, Query
import subprocess

app = FastAPI()

@app.get("/")
def root():
    return {"status": "Sherlock API is live"}

@app.get("/search")
def sherlock_search(username: str = Query(...)):
    try:
        result = subprocess.run(
            ["python3", "sherlock/sherlock.py", username, "--print-found"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=120
        )
        output = result.stdout.strip()
        if output:
            return {"results": output}
        else:
            return {"results": "No matches found"}
    except subprocess.TimeoutExpired:
        return {"error": "Search took too long"}
    except Exception as e:
        return {"error": str(e)}
