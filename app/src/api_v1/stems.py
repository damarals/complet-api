from fastapi import APIRouter

from .utils import convert_to_mp3, download_youtube_video

router = APIRouter()

@router.get("/")
async def list_stems():
    results = {"Success": "All stems!"}
    return results

@router.post("/find/{id}")
async def find_stem(stem_id: str):
    results = {"Success": f"This is the stem with id: {stem_id}"}
    return results

@router.post("/extract")
async def extract_stem(youtube_url: str):
    video_filename = download_youtube_video(youtube_url)
    audio_filename = convert_to_mp3(video_filename)

    results = {"Success": f"Stems generated from YouTube video: {youtube_url}. Video file: {video_filename}. Audio file: {audio_filename}"}
    return results