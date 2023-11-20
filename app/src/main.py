import os
from fastapi import FastAPI
from mangum import Mangum

env = os.environ.get("API_ENV")
version = os.environ.get("API_VERSION")

app = FastAPI(
    root_path = f"/{version}/",
    docs_url = "/docs",
    title = "My Awesome FastAPI app",
    description = "This is super fancy, with auto docs and everything!",
    version = version
)

@app.get("/", name="API Root", tags=["API Root"])
async def api_root():
    return { "success": "Welcome to the API!" }

@app.get("/ping", name="Healthcheck", tags=["Healthcheck"])
async def healthcheck():
    return { "success": "pong!" }


handler = Mangum(app)
