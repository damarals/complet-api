import os
from fastapi import FastAPI
from mangum import Mangum

stage = os.environ.get("API_STAGE")

app = FastAPI(
    root_path = f"/{stage}/" if stage else "",
    docs_url = "/api/docs",
    title = "My Awesome FastAPI app",
    description = "This is super fancy, with auto docs and everything!",
    version = "0.0.1",
)

@app.get("/ping", name="Healthcheck", tags=["Healthcheck"])
async def healthcheck():
    return { "success": "pong!" }

@app.get("/api", name="API Root", tags=["API Root"])
async def api_root():
    return { "success": "Welcome to the API!" }

handler = Mangum(app)
