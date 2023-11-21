from pytube import YouTube
from moviepy.editor import VideoFileClip
import uuid

def convert_to_mp3(filename: str):
    audio_filename = f'{filename[:-4]}.mp3'
    clip = VideoFileClip(filename)
    clip.audio.write_audiofile(audio_filename)
    clip.close()
    return audio_filename

def download_youtube_video(url: str):
    os.makedirs("/tmp/raw", exist_ok=True) 
    default_filename = f'/tmp/raw/{uuid.uuid4()}.mp4'
    video = YouTube(url)
    stream = video.streams.get_by_itag(18)
    stream.download(filename = default_filename)
    return default_filename