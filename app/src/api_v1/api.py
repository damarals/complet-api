from fastapi import APIRouter

from .stems import router as stems_router

router = APIRouter()

router.include_router(stems_router, prefix="/stems", tags=["Stems"])