import os
from fastapi import FastAPI
from mangum import Mangum
from api_v1.api import router as api_router

env = os.environ.get("API_ENV")
stage_version = os.environ.get("API_VERSION") # stage version (e.g. v1, v2, etc.)

app = FastAPI(
    root_path = f"/{stage_version}/",
    docs_url = "/docs",
    title = "Complet API",
    description = "API for extract stems from YouTube videos using deep learning, making it easy to recreate full band sound with missing instruments.",
    version = "0.1.0" # release version (e.g. 1.0.0, 1.0.1, etc.)
)

@app.get("/", name="API Root", tags=["API Root"])
async def api_root():
    return { "success": "Welcome to the Complet API!" }

app.include_router(api_router)

handler = Mangum(app)
