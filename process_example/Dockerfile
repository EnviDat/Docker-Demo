FROM python:3.10 as build
# Install system build requirements
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential \
        gcc
# Copy python dependencies file
COPY requirements.txt .
# Install dependencies to user directory (i.e. default is root)
RUN pip install --user --no-warn-script-location \
    --no-cache-dir -r ./requirements.txt



FROM python:3.10 as runtime
# Python specific environment variables for containers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PATH="/root/.local/bin:$PATH"
# Copy dependencies from build stage above
# NOTE: ideally we would copy to non-root user, but for processing it doesn't matter
COPY --from=build \
    /root/.local \
    /root/.local
# Set current working directory (permanently)
WORKDIR /code
# Copy your python script
COPY script.py .
# Set the commands that run when a container is spawned
ENTRYPOINT ["python"]
CMD ["script.py"]
