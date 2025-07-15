import uvicorn
from fastapi import FastAPI 

app = FastAPI()

@app.get("/")
def add():
    a = 1
    b = 2
    return a + b

uvicorn.run(app, host = '127.0.0.1', port = 8000)    