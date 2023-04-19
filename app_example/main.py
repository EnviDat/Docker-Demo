import sys
import logging

from fastapi import FastAPI


logging.basicConfig(
    level="DEBUG",
    format=(
        "%(asctime)s.%(msecs)03d [%(levelname)s] "
        "%(name)s | %(funcName)s:%(lineno)d | %(message)s"
    ),
    datefmt="%y-%m-%d %H:%M:%S",
    stream=sys.stdout,
)

log = logging.getLogger(__name__)


app = FastAPI(
    title="Demo App",
    description="Test app for python/docker demo.",
    version="0.1.0",
    debug=True,
)

@app.get("/")
async def main():
    """Main page."""
    log.info("Returning main page message")
    return {"message": "Hello demo app!"}
